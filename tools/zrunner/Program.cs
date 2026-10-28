// zrunner: joga uma história Z-machine com um arquivo de comandos, usando o
// ZLR em modo de aleatoriedade previsível (o mesmo modo da suíte de testes do
// ZILF). Imprime a transcrição da janela principal na saída padrão.
//
// Uso: zrunner <historia.z3|z5> <comandos.txt>
//
// Linhas do arquivo de comandos que começam com "##" são comentários.
// Saves ficam na memória: "save" guarda e "restore" volta ao último save.

using System.Text;
using ZLR.VM;

if (args.Length != 2)
{
    Console.Error.WriteLine("uso: zrunner <historia> <comandos.txt>");
    return 2;
}

var commands = File.ReadAllLines(args[1], Encoding.UTF8)
    .Select(l => l.TrimEnd('\r'))
    .Where(l => !l.StartsWith("##"))
    .ToList();

Console.OutputEncoding = new UTF8Encoding(false);
var io = new ScriptedIO(commands);
await using var story = File.OpenRead(args[0]);
var zm = new ZMachine(story, io) { PredictableRandom = true };

try
{
    zm.Run();
}
catch (Exception e) when (e is CommandsExhaustedException ||
                          e.InnerException is CommandsExhaustedException)
{
}
finally
{
    io.Flush();
}

return 0;

sealed class CommandsExhaustedException : Exception;

sealed class ScriptedIO(List<string> commands) : IZMachineIO
{
    readonly StringBuilder output = new();
    int next;
    short currentWindow;
    byte[]? savedGame;

    public void Flush()
    {
        Console.Write(output.ToString());
        output.Clear();
    }

    string NextCommand()
    {
        if (next >= commands.Count)
            throw new CommandsExhaustedException();
        var cmd = commands[next++];
        output.Append(cmd).Append('\n');
        return cmd;
    }

    public ReadLineResult ReadLine(string initial, int time, TimedInputCallback callback,
        byte[] terminatingKeys, bool allowDebuggerBreak) => ReadLineResult.LineEntered(NextCommand());

    public short ReadKey(int time, TimedInputCallback callback, CharTranslator translator)
    {
        var cmd = NextCommand();
        return (short)(cmd.Length > 0 ? cmd[0] : 13);
    }

    public void PutCommand(string command) { }

    public void PutChar(char ch)
    {
        if (currentWindow == 0)
            output.Append(ch);
    }

    public void PutString(string str)
    {
        if (currentWindow == 0)
            output.Append(str);
    }

    public void PutTextRectangle(string[] lines) { }

    public bool Buffering { get; set; }
    public bool Transcripting { get; set; }
    public void PutTranscriptChar(char ch) { }
    public void PutTranscriptString(string str) { }

    public Stream? OpenSaveFile(int size) => new CapturingStream(bytes => savedGame = bytes);
    public Stream? OpenRestoreFile() => savedGame == null ? null : new MemoryStream(savedGame, false);
    public Stream? OpenAuxiliaryFile(string name, int size, bool writing) => null;
    public Stream? OpenCommandFile(bool writing) => null;

    public void SetTextStyle(TextStyle style) { }
    public void SplitWindow(short lines) { }
    public void SelectWindow(short num) => currentWindow = num;
    public void EraseWindow(short num) { }
    public void EraseLine() { }
    public void MoveCursor(short x, short y) { }
    public void GetCursorPos(out short x, out short y) { x = 1; y = 1; }
    public void SetColors(short fg, short bg) { }
    public short SetFont(short num) => 0;
    public bool DrawCustomStatusLine(string location, short hoursOrScore, short minsOrTurns, bool useTime) => true;
    public void PlaySoundSample(ushort number, SoundAction action, byte volume, byte repeats,
        SoundFinishedCallback callback) { }
    public void PlayBeep(bool highPitch) { }
    public bool ForceFixedPitch { get; set; }
    public bool VariablePitchAvailable => false;
    public bool ScrollFromBottom { get; set; }
    public bool BoldAvailable => false;
    public bool ItalicAvailable => false;
    public bool FixedPitchAvailable => true;
    public bool TimedInputAvailable => false;
    public bool SoundSamplesAvailable => false;
    public bool GraphicsFontAvailable => false;
    public bool ColorsAvailable => false;
    public bool UndoAvailable => true;
    public byte WidthChars => 80;
    public short WidthUnits => 80;
    public byte HeightChars => 255;
    public short HeightUnits => 255;
    public byte FontHeight => 1;
    public byte FontWidth => 1;
    public byte DefaultForeground => 9;
    public byte DefaultBackground => 2;
    public Encoding? Encoding => Encoding.UTF8;

    public event EventHandler? SizeChanged { add { } remove { } }

    public UnicodeCaps CheckUnicode(char ch) => UnicodeCaps.CanPrint | UnicodeCaps.CanInput;
    public bool CheckInput(char ch) => true;
}

sealed class CapturingStream(Action<byte[]> onClose) : MemoryStream
{
    protected override void Dispose(bool disposing)
    {
        if (disposing)
            onClose(ToArray());
        base.Dispose(disposing);
    }
}

import sys
import whisper


def main():
    # 从命令行参数读取音频文件路径
    if len(sys.argv) != 2:
        print("Usage: python whisper_main.py <audio_file_path>", file=sys.stderr)
        sys.exit(1)

    audio_path = sys.argv[1]

    # 加载 Whisper 模型并处理音频文件
    try:
        model = whisper.load_model("large")
        result = model.transcribe(audio_path)
        transcription = result["text"]
        print(transcription)  # 返回转录文本
    except Exception as e:
        print(f"Error: {e}", file=sys.stderr)
        sys.exit(1)


if __name__ == "__main__":
    main()
import sys
import pandas as pd
from googletrans import Translator

def main():
    if len(sys.argv) < 2:
        print("Usage: python translate_helper.py input.csv")
        sys.exit(1)

    input_csv = sys.argv[1]

    # Read input CSV
    df = pd.read_csv(input_csv, header=None, names=['text'], encoding='utf-8')

    translator = Translator()
    translations = []

    for txt in df['text']:
        if pd.isna(txt) or str(txt).strip() == "":
            translations.append("")
        else:
            try:
                result = translator.translate(str(txt), dest='en')
                translations.append(result.text)
            except Exception as e:
                translations.append(f"[ERROR: {e}]")

    # Output translations line by line (no header)
    pd.DataFrame(translations).to_csv(sys.stdout, index=False, header=False)

if __name__ == "__main__":
    main()

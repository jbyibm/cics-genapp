#!/usr/bin/env python3
"""
Script to convert UTF-8 files to pure ASCII
Removes or replaces non-ASCII characters
"""

import sys
import argparse
from pathlib import Path

# Mapping of common special characters to ASCII
CHAR_MAP = {
    # Emojis
    '📊': '[Chart]',
    '🚀': '[Rocket]',
    '📂': '[Folder]',
    '💡': '[Idea]',
    '📋': '[Clipboard]',
    '⚙️': '[Settings]',
    '✅': '[OK]',
    '❌': '[X]',
    '🌐': '[Globe]',
    '📖': '[Book]',

    # Checks and symbols
    '✓': '[OK]',
    '✔': '[OK]',
    '✨': '*',

    # Arrows
    '→': '->',
    '←': '<-',
    '↑': '^',
    '↓': 'v',
    '⇒': '=>',
    '⇐': '<=',

    # Bullets
    '•': '*',
    '◦': '-',
    '▪': '-',
    '▫': '-',
    '–': '-',
    '—': '--',

    # Quotes
    '"': '"',
    '"': '"',
    ''': "'",
    ''': "'",
    '«': '"',
    '»': '"',

    # Symbols
    '…': '...',
    '€': 'EUR',
    '©': '(c)',
    '®': '(R)',
    '™': '(TM)',
    '°': 'deg',
    '±': '+/-',
    '×': 'x',
    '÷': '/',
    '≈': '~=',
    '≠': '!=',
    '≤': '<=',
    '≥': '>=',

    # French and other special characters
    'à': 'a',
    'á': 'a',
    'â': 'a',
    'ä': 'a',
    'è': 'e',
    'é': 'e',
    'ê': 'e',
    'ë': 'e',
    'ì': 'i',
    'í': 'i',
    'î': 'i',
    'ï': 'i',
    'ò': 'o',
    'ó': 'o',
    'ô': 'o',
    'ö': 'o',
    'ù': 'u',
    'ú': 'u',
    'û': 'u',
    'ü': 'u',
    'ç': 'c',
    'ñ': 'n',
    'À': 'A',
    'Á': 'A',
    'Â': 'A',
    'Ä': 'A',
    'È': 'E',
    'É': 'E',
    'Ê': 'E',
    'Ë': 'E',
    'Ì': 'I',
    'Í': 'I',
    'Î': 'I',
    'Ï': 'I',
    'Ò': 'O',
    'Ó': 'O',
    'Ô': 'O',
    'Ö': 'O',
    'Ù': 'U',
    'Ú': 'U',
    'Û': 'U',
    'Ü': 'U',
    'Ç': 'C',
    'Ñ': 'N',
}


def convert_to_ascii(text, remove_unknown=False):
    """
    Converts UTF-8 text to ASCII
    
    Args:
        text: Text to convert
        remove_unknown: If True, removes unknown characters, 
                       otherwise replaces them with '?'
    
    Returns:
        Converted ASCII text
    """
    result = text

    # Replace mapped characters
    for utf8_char, ascii_char in CHAR_MAP.items():
        result = result.replace(utf8_char, ascii_char)

    # Handle remaining non-ASCII characters
    if remove_unknown:
        # Remove non-ASCII characters
        result = ''.join(char for char in result if ord(char) < 128)
    else:
        # Replace with '?'
        result = ''.join(char if ord(char) < 128 else '?' for char in result)

    return result


def process_file(input_file, output_file=None, inplace=False,
                remove_unknown=False, backup=True):
    """
    Processes a file to convert it to ASCII
    
    Args:
        input_file: Input file
        output_file: Output file (optional)
        inplace: If True, modifies the file in place
        remove_unknown: If True, removes unknown characters
        backup: If True and inplace, creates a .bak backup
    """
    input_path = Path(input_file)

    if not input_path.exists():
        print(f"Error: File not found: {input_file}")
        return False

    try:
        # Read the file
        print(f"Reading {input_file}...")
        with open(input_path, 'r', encoding='utf-8', errors='replace') as f:
            content = f.read()

        # Convert to ASCII
        print("Converting to ASCII...")
        ascii_content = convert_to_ascii(content, remove_unknown)

        # Calculate statistics
        original_size = len(content)
        converted_size = len(ascii_content)
        non_ascii_count = sum(1 for c in content if ord(c) >= 128)

        # Determine output file
        if inplace:
            # Create backup if requested
            if backup:
                backup_path = input_path.with_suffix(input_path.suffix + '.bak')
                print(f"Creating backup: {backup_path}")
                with open(backup_path, 'w', encoding='utf-8') as f:
                    f.write(content)

            output_path = input_path
            print(f"Modifying in place: {output_path}")
        elif output_file:
            output_path = Path(output_file)
            print(f"Writing to: {output_path}")
        else:
            # Create filename with _ascii suffix
            output_path = input_path.with_stem(input_path.stem + '_ascii')
            print(f"Writing to: {output_path}")

        # Write output file
        with open(output_path, 'w', encoding='ascii', errors='replace') as f:
            f.write(ascii_content)

        # Display statistics
        print("\n" + "="*60)
        print("RESULT:")
        print("="*60)
        print(f"Input file:           {input_path}")
        print(f"Output file:          {output_path}")
        print(f"Original size:        {original_size} characters")
        print(f"Converted size:       {converted_size} characters")
        print(f"Non-ASCII characters: {non_ascii_count}")
        print(f"Action:               {'Removed' if remove_unknown else 'Replaced'}")
        print("="*60)

        return True

    except Exception as e:
        print(f"Error during processing: {e}")
        import traceback
        traceback.print_exc()
        return False


def main():
    parser = argparse.ArgumentParser(
        description='Convert UTF-8 files to pure ASCII',
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  # Create a new file with _ascii suffix
  python utf8_to_ascii.py my_file.sql
  
  # Modify file in place (with .bak backup)
  python utf8_to_ascii.py my_file.sql -i
  
  # Modify in place without backup
  python utf8_to_ascii.py my_file.sql -i --no-backup
  
  # Specify output file
  python utf8_to_ascii.py input.sql -o output.sql
  
  # Remove unknown characters instead of replacing with '?'
  python utf8_to_ascii.py my_file.sql -r
  
  # Process multiple files
  python utf8_to_ascii.py *.sql -i
        """
    )

    parser.add_argument('input', nargs='+',
                       help='Input file(s) to convert')
    parser.add_argument('-o', '--output',
                       help='Output file (ignored if multiple files)')
    parser.add_argument('-i', '--inplace', action='store_true',
                       help='Modify file in place')
    parser.add_argument('--no-backup', action='store_true',
                       help='Don\'t create .bak backup (with -i)')
    parser.add_argument('-r', '--remove', action='store_true',
                       help='Remove unknown characters instead of replacing with ?')

    args = parser.parse_args()

    # Process files
    success_count = 0
    fail_count = 0

    for input_file in args.input:
        print("\n" + "#"*60)
        print(f"# Processing: {input_file}")
        print("#"*60)

        # If multiple files, ignore -o option
        output_file = args.output if len(args.input) == 1 else None

        if process_file(
            input_file,
            output_file,
            args.inplace,
            args.remove,
            not args.no_backup
        ):
            success_count += 1
        else:
            fail_count += 1

    # Final summary
    print("\n" + "="*60)
    print("FINAL SUMMARY")
    print("="*60)
    print(f"Successfully processed files: {success_count}")
    if fail_count > 0:
        print(f"Failed files:                 {fail_count}")
    print("="*60)

    return 0 if fail_count == 0 else 1


if __name__ == '__main__':
    sys.exit(main())

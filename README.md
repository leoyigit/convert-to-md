# Convert to Markdown

A lightweight terminal utility for converting documents, spreadsheets, PDFs, and entire folders into Markdown.

Developed by **Leo Yigit Ekiz**  
GitHub: [github.com/leoyigit](https://github.com/leoyigit)

---

## Why this exists

Markdown is easy to read, easy to version, easy to search, and works well with GitHub, documentation systems, note-taking tools, AI workflows, and static sites.

But source files often arrive as:

- Word documents
- Excel spreadsheets
- PDFs
- CSV files
- HTML
- Plain text
- Other document formats

`convert-to-md` gives you one simple command:

```bash
convert
```

Then drag a file or folder into your terminal.

The tool creates `.md` files next to the originals.

---

## Features

- Convert a single file to Markdown
- Convert an entire folder recursively
- Keep generated `.md` files beside the originals
- Extract embedded images into an `images_<name>` folder so the Markdown renders them
- Supports Word documents
- Supports Excel workbooks
- Supports CSV and TSV files
- Supports PDFs
- Supports HTML and EPUB
- Supports plain text
- Converts every Excel sheet into its own Markdown section
- Works from anywhere in the terminal after installation
- Simple interactive drag-and-drop workflow
- Open source under the MIT License

---

## Supported formats

| Format | Supported | Notes |
|---|---:|---|
| `.docx` | Yes | Converted using Pandoc, images extracted |
| `.odt` | Yes | Converted using Pandoc, images extracted |
| `.rtf` | Yes | Converted using Pandoc, images extracted |
| `.html` | Yes | Converted using Pandoc |
| `.htm` | Yes | Converted using Pandoc |
| `.epub` | Yes | Converted using Pandoc, images extracted |
| `.pdf` | Yes | Text extracted with `pdftotext` |
| `.txt` | Yes | Converted directly |
| `.csv` | Yes | Converted to Markdown tables |
| `.tsv` | Yes | Converted to Markdown tables |
| `.xlsx` | Yes | Every worksheet becomes a Markdown section |
| `.xls` | Yes | Every worksheet becomes a Markdown section |
| `.json` | Yes | Wrapped in a Markdown JSON code block |

---

## Installation

### macOS

Install the required system dependencies:

```bash
brew install pandoc poppler
```

Check that Python 3 is available:

```bash
python3 --version
```

Install the Python dependencies:

```bash
python3 -m pip install pandas openpyxl xlrd tabulate
```

Clone the repository:

```bash
git clone https://github.com/leoyigit/convert-to-md.git
cd convert-to-md
```

Make the installer executable and run it:

```bash
chmod +x install.sh
./install.sh
```

Restart Terminal if necessary.

You can now run:

```bash
convert
```

from anywhere.

---

## Usage

### Interactive mode

Run:

```bash
convert
```

You will see:

```text
Convert to Markdown

Drag a file or folder into this Terminal window.
Then press Enter:
```

Drag your file or folder from Finder into the Terminal window, then press Enter.

### Convert a single file

```bash
convert ~/Desktop/report.docx
```

Example:

```text
Desktop/
├── report.docx
└── report.md
```

If the document contains images, they are saved next to it:

```text
Desktop/
├── report.docx
├── report.md
└── images_report/
    ├── image1.png
    └── image2.jpeg
```

The original file is not modified.

### Convert an entire folder

```bash
convert ~/Desktop/project
```

The tool scans the folder recursively and converts all supported files.

Example:

```text
project/
├── proposal.docx
├── proposal.md
├── images_proposal/
│   └── image1.png
├── products.xlsx
├── products.md
├── research.pdf
├── research.md
├── data.csv
├── data.md
├── notes.txt
└── notes.md
```

Subfolders are scanned too.

---

## Images in documents

Images embedded in Word, OpenDocument, RTF and EPUB files are extracted automatically.

They are saved in a folder named `images_<name>` next to the generated Markdown file, and the Markdown links point to that folder with relative paths:

```markdown
# Quarterly Report

Sales grew in every region.

![](images_report/image1.png)
```

Because the links are relative, the `.md` file and its `images_` folder can be moved or committed together and the images keep rendering in GitHub, VS Code, Obsidian and other Markdown viewers.

Notes:

- Re-running the conversion replaces the `images_<name>` folder, just like it replaces the `.md` file
- Documents without images do not get an images folder
- Images in PDFs are not extracted yet

---

## Excel conversion

Excel workbooks can contain multiple worksheets.

Each worksheet is converted into its own Markdown section.

Example:

```markdown
# Products

| SKU | Product | Price |
|---|---|---:|
| 001 | Coffee | 12.00 |
| 002 | Tea | 8.00 |

---

# Inventory

| SKU | Stock |
|---|---:|
| 001 | 120 |
| 002 | 80 |
```

---

## CSV conversion

CSV and TSV files are converted into Markdown tables.

Example input:

```csv
name,price,stock
Coffee,12,30
Tea,8,50
```

Example output:

```markdown
| name   | price | stock |
|--------|------:|------:|
| Coffee | 12    | 30    |
| Tea    | 8     | 50    |
```

---

## PDF conversion

PDF files are supported, but PDF is primarily a visual layout format rather than a structured document format.

As a result, conversion may not perfectly preserve:

- Headings
- Columns
- Tables
- Reading order
- Footnotes
- Complex layouts
- Embedded graphics

Simple text-based PDFs generally convert well.

Scanned PDFs without embedded text are not currently OCR'd.

---

## Commands

Start interactive conversion:

```bash
convert
```

Convert a file:

```bash
convert document.docx
```

Convert a folder:

```bash
convert ./documents
```

Show help:

```bash
convert --help
```

Show version:

```bash
convert --version
```

---

## Project structure

```text
convert-to-md/
├── convert
├── install.sh
├── uninstall.sh
├── README.md
├── LICENSE
└── .gitignore
```

### `convert`

The main command-line utility.

### `install.sh`

Installs the `convert` command into the user's local binary directory.

### `uninstall.sh`

Removes the installed command.

### `README.md`

Project documentation.

### `LICENSE`

MIT open-source license.

---

## Dependencies

- Bash
- Pandoc
- Poppler / `pdftotext`
- Python 3
- pandas
- openpyxl
- xlrd
- tabulate

---

## Uninstall

From the repository directory:

```bash
chmod +x uninstall.sh
./uninstall.sh
```

This removes:

```text
~/.local/bin/convert
```

---

## Troubleshooting

### `convert: command not found`

Restart your terminal.

If it still does not work, check whether `~/.local/bin` is in your PATH:

```bash
echo $PATH
```

You should see something similar to:

```text
/Users/yourname/.local/bin
```

You can add it manually:

```bash
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

### `pandoc: command not found`

```bash
brew install pandoc
```

### `pdftotext: command not found`

```bash
brew install poppler
```

### Missing Python package

```bash
python3 -m pip install pandas openpyxl xlrd tabulate
```

---

## Current limitations

This is intentionally a lightweight CLI utility.

Current limitations include:

- Scanned PDFs are not OCR'd
- Images inside PDFs are not extracted
- Images in HTML files are not downloaded
- Highly complex Word layouts may lose formatting
- Complex Excel formatting is not preserved
- Macros are not supported
- Charts are not converted
- Existing Markdown files are skipped

---

## Roadmap

Possible future improvements:

- Linux installation support
- Windows support
- OCR for scanned PDFs
- Image extraction from PDF
- Custom output directory
- Overwrite confirmation
- Dry-run mode
- Batch conversion summaries
- Improved error reporting
- Optional recursive/non-recursive folder mode
- Homebrew installation
- Automatic dependency installation
- Additional file formats

---

## Contributing

Contributions, bug reports, and suggestions are welcome.

You can:

- Report bugs
- Suggest new formats
- Improve conversion quality
- Improve installation support
- Submit pull requests

Open an issue or pull request on GitHub.

---

## Author

**Leo Yigit Ekiz**

GitHub: [@leoyigit](https://github.com/leoyigit)

Project: [github.com/leoyigit/convert-to-md](https://github.com/leoyigit/convert-to-md)

---

## License

This project is licensed under the MIT License.

You are free to use, modify, distribute, and include it in your own projects under the terms of the license.

See [`LICENSE`](LICENSE) for details.

---

Made by **Leo Yigit Ekiz**.

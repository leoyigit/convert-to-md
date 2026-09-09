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
- Supports PDFs, keeping headings, columns, lists, tables, images and graphics
- Reads scanned PDFs with OCR when Tesseract is installed
- Supports HTML and EPUB
- Supports plain text
- Converts every Excel sheet into its own Markdown section
- Works from anywhere in the terminal after installation
- Double-click installer for macOS
- Built-in `convert --update` command and a daily new-version notice
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
| `.pdf` | Yes | Layout read with PyMuPDF: headings, columns, lists, tables, images and graphics extracted; scanned pages OCR'd when Tesseract is installed |
| `.txt` | Yes | Converted directly |
| `.csv` | Yes | Converted to Markdown tables |
| `.tsv` | Yes | Converted to Markdown tables |
| `.xlsx` | Yes | Every worksheet becomes a Markdown section |
| `.xls` | Yes | Every worksheet becomes a Markdown section |
| `.json` | Yes | Wrapped in a Markdown JSON code block |

---

## Installation

### macOS, one click

1. Download the project as a ZIP from GitHub (green **Code** button, then **Download ZIP**) and unzip it, or clone it with git.
2. Open the folder and double-click **`Install.command`**.

A Terminal window opens, offers to install any missing dependencies with Homebrew and pip, and installs the `convert` command.

If macOS says the file cannot be opened because it is from an unidentified developer, right-click `Install.command`, choose **Open**, and confirm. This is only needed the first time.

To remove the tool later, double-click **`Uninstall.command`**.

### macOS, terminal, no ZIP required

To install directly from the terminal without downloading a ZIP:

```bash
curl -fsSL https://raw.githubusercontent.com/leoyigit/convert-to-md/main/install.sh | bash
```

The installer automatically installs Homebrew if needed, then installs the
required system and Python packages before installing the `convert` command.
macOS may ask for your administrator password while installing Homebrew.

Open a new Terminal window, then run `convert` from anywhere.

The installer places the command in `~/.local/bin` and adds that directory to
your shell's startup file. It does not require Git or a local copy of the
repository.

For a git-based installation instead, use the steps below.

Install the required system dependencies:

```bash
brew install pandoc
```

Check that Python 3 is available:

```bash
python3 --version
```

Install the Python dependencies:

```bash
python3 -m pip install pandas openpyxl xlrd tabulate pymupdf
```

Optional, for scanned PDFs:

```bash
brew install tesseract
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

## Updating

Update from the terminal at any time:

```bash
convert --update
```

This downloads the latest version from GitHub and replaces the installed command. Nothing else on your system is touched.

To only check whether a newer version exists:

```bash
convert --check-update
```

### New-version notice

Once a day, when you run `convert`, it quietly asks GitHub for the latest version number in the background. The check never delays the conversion. If a newer version exists you will see:

```text
A new version is available: 1.3.0 (you have 1.2.0)
Update with:

  convert --update
```

To turn the check off, add this line to your `~/.zshrc`:

```bash
export CONVERT_NO_UPDATE_CHECK=1
```

If you installed with `git clone`, `git pull` followed by `./install.sh` works as well.

Version 1.3.0 added PyMuPDF for PDF conversion. If you updated with `convert --update` from an older version, install it once:

```bash
python3 -m pip install pymupdf
```

Until then PDFs are converted as plain text with `pdftotext`, and `convert` prints a reminder.

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

Images embedded in Word, OpenDocument, RTF, EPUB and PDF files are extracted automatically.

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
- PDF pictures are named after their page, for example `page04_image1.jpg` or `page14_art2.png`

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

PDF is a visual layout format, so the tool reads the layout of every page with PyMuPDF and rebuilds the document from it:

- Headings are recognised from the font sizes used in the document and become `#`, `##`, `###` and `####`
- Columns and cards are read one after the other instead of line by line across the page
- Bullet and numbered lists become Markdown lists
- Tables with ruled lines become Markdown tables
- Bold and italic text keeps its emphasis
- Running headers, footers and page numbers are removed
- Letter-spaced text such as `S P O O N F U L` is kept as one word
- Embedded photos are saved at their original quality, and each photo is saved only once even when it appears on several pages
- Vector graphics such as logos, icons, colour swatches and charts are rendered as PNG pictures
- Pages without a text layer are OCR'd when Tesseract is installed (`brew install tesseract`), otherwise they are saved as images

The result is a Markdown file that reads in the natural order of the page, with the pictures in place:

```markdown
# 03 Color

### Flavor Color Palette

Our flavor palette pulls color straight from the table...

![Page 14 graphic](images_brandbook/page14_art1.png)

#### Blueberry Milk

HEX: #C0C5E4 CMYK: 0.16, 0.14, 0.00, 0.11 RGB: 192, 197, 228
```

Notes:

- Reading order follows the visual gaps on the page. Unusual layouts can still come out in a different order than intended
- Text drawn inside a rendered graphic is kept in the Markdown as well, so it stays searchable
- OCR uses English by default. Set `CONVERT_OCR_LANG` to another installed Tesseract language, for example `CONVERT_OCR_LANG=deu`
- Without PyMuPDF the tool falls back to plain text extraction with `pdftotext`

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

Update to the latest version:

```bash
convert --update
```

Check for a newer version without installing it:

```bash
convert --check-update
```

---

## Project structure

```text
convert-to-md/
├── convert
├── Install.command
├── Uninstall.command
├── install.sh
├── uninstall.sh
├── README.md
├── LICENSE
└── .gitignore
```

### `convert`

The main command-line utility.

### `Install.command` and `Uninstall.command`

Double-click installers for macOS. They open Terminal and run the scripts below.

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
- Python 3
- PyMuPDF (`pymupdf`)
- pandas
- openpyxl
- xlrd
- tabulate
- Tesseract, optional, for scanned PDFs
- Poppler / `pdftotext`, optional, plain-text fallback for PDFs when PyMuPDF is missing

---

## Uninstall

Double-click `Uninstall.command`, or from the repository directory:

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

### `Python package 'pymupdf' is not installed`

```bash
python3 -m pip install pymupdf
```

If pip refuses because the Python installation is "externally managed", add `--user --break-system-packages`.

### Missing Python package

```bash
python3 -m pip install pandas openpyxl xlrd tabulate pymupdf
```

### A scanned PDF only produced images

Install Tesseract and convert again:

```bash
brew install tesseract
```

---

## Current limitations

This is intentionally a lightweight CLI utility.

Current limitations include:

- Scanned PDFs are only OCR'd when Tesseract is installed
- PDF reading order can differ from the intended order on unusual layouts
- Tables without ruled lines in PDFs are converted as text
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
- Table detection for PDF tables without ruled lines
- OCR language auto-detection
- Custom output directory
- Overwrite confirmation
- Dry-run mode
- Batch conversion summaries
- Improved error reporting
- Optional recursive/non-recursive folder mode
- Homebrew installation
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

# macOS Transparency Control

A shell script for managing macOS transparency and appearance settings, originally developed on macOS 26 Beta to optimize the Liquid Glass design's performance on Intel Macs (tested on 2019 16" MacBook Pro). Useful for anyone seeking quick access to appearance and accessibility controls.

## Features

- �️ Fine-tune transparency levels (0.0 - 1.0)
- �🎨 Control system transparency settings
- 🔲 Adjust contrast levels
- 👆 Toggle button shapes
- 🌫️ Manage blur effects
- 🌓 Switch between light and dark mode
- ⚡ Quick preset configurations
- 🎯 Interactive command-line interface
- 🎨 Color-coded output for better visibility
- 🖥️ Optimized for Intel Macs

## Requirements

- macOS (developed on macOS 26 Beta, compatible with Ventura+)
- zsh shell (default on modern macOS)
- Administrative privileges
- Optimized for Intel Macs, compatible with all hardware

## Installation

1. Clone this repository:
```bash
git clone https://github.com/yourusername/macos-transparency-control.git
cd macos-transparency-control
```

2. Make the script executable:
```bash
chmod +x transparency-control.sh
```

## Usage

Run the script from the terminal:
```bash
./transparency-control.sh
```

### Available Presets

1. Full Transparency - Default macOS Liquid Glass effect
2. Optimized Transparency - Balanced preset for Intel Macs (25% reduced)
3. Medium Transparency - 50% reduced transparency
4. No Transparency - Maximum performance mode

### Fine-Tuning Controls

The script provides precise transparency adjustment:
- Use the 't' option to enter a custom transparency level
- Values range from 0.0 (full transparency) to 1.0 (no transparency)
- Real-time preview of changes
- Perfect for finding your ideal balance of aesthetics and performance

### Manual Controls

The script allows individual control of:
- Reduce Transparency
- Increase Contrast
- Button Shapes
- Beta Blur Effect
- Appearance Mode (Light/Dark)
- Custom Transparency Level

## Note

- Some changes require logging out and back in to take full effect
- The script will prompt you when a logout is necessary
- You can cancel the automatic logout by pressing Ctrl+C when prompted

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Author

morpson
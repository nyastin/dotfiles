# Dotfiles Setup Guide

## Setup Steps

1. **Install Homebrew**

   1. Open a terminal and run:
      ```sh
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
      ```

2. **Install the following packages using Homebrew:**

   1. `stow`
   2. `alacritty`
   3. `tmux`
   4. `eza`
   5. `zsh-syntax-highlighting`
   6. `zsh-autosuggestions`
   7. `zoxide`
   8. `starship`
   9. `gh`
   10. `ripgrep`
   11. `tree`
   12. `lazygit`
   13. `fd`

   Run the following command in the terminal:

   ```sh
   brew install stow alacritty tmux eza zsh-syntax-highlighting zsh-autosuggestions zoxide starship gh ripgrep tree lazygit fd
   ```

3. **Install Rust (needed for Cargo)**

   1. Follow the instructions on [Rust's official website](https://www.rust-lang.org/tools/install). This will install `cargo` as well.

   ```sh
   curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
   ```

4. **Install Bob using Cargo**

   1. Run the following command in the terminal:
      ```sh
      cargo install bob-nvim
      ```
   2. Install and use the stable version of Neovim:
      ```sh
      bob install stable
      bob use stable
      ```

5. **Clone your dotfiles repository**

   1. Run the following command in the terminal:
      ```sh
      git clone https://github.com/nyastin/dotfiles ~/.config
      ```

6. **Clone Tmux Plugin Manager (TPM)**

   1. Run the following command in the terminal:
      ```sh
      git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
      ```

7. **Use Stow to manage dotfiles**

   1. Navigate to the `.config` directory:
      ```sh
      cd ~/.config
      ```
   2. Stow the desired dotfiles:
      ```sh
      stow nvim
      stow zsh
      stow alacritty
      stow starship
      ```

8. **Tmux plugins installation**

   1. Run the `tmux` command:
   2. Press `prefix + I` (capital i, as in Install) to fetch the plugins listed stored in .tmux.conf.
      Plugin Inclusions:
      ```sh
      catppuccin/tmux
      tmux-plugins/tmux-battery
      ```

### Additional Notes

- Ensure that you have `git` installed to clone your dotfiles repository.
- Adjust the list of packages in step 2 as needed based on your preferences.
- If you encounter any issues during the installation of Rust or other tools, refer to their respective documentation for troubleshooting.

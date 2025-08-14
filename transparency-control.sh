#!/bin/bash

# macOS Transparency Control Interactive Script
# Allows quick adjustment of transparency and appearance settings

# Colors for better UI
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[0;37m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# Function to get current setting values
get_current_settings() {
    REDUCE_TRANSPARENCY=$(defaults read com.apple.universalaccess reduceTransparency 2>/dev/null || echo "0")
    INCREASE_CONTRAST=$(defaults read com.apple.universalaccess increaseContrast 2>/dev/null || echo "0")
    BUTTON_SHAPES=$(defaults read com.apple.universalaccess buttonShapes 2>/dev/null || echo "0")
    MORAEA_BLUR=$(defaults read NSGlobalDomain Moraea_BlurBeta 2>/dev/null || echo "0")
    DARK_MODE=$(defaults read NSGlobalDomain AppleInterfaceStyle 2>/dev/null || echo "Light")
}

# Function to display current settings
show_current_settings() {
    get_current_settings
    echo -e "\n${BOLD}${CYAN}=== Current Transparency Settings ===${NC}"
    echo -e "${WHITE}1. Reduce Transparency:${NC} $([ "$REDUCE_TRANSPARENCY" = "1" ] && echo -e "${GREEN}ON${NC}" || echo -e "${RED}OFF${NC}")"
    echo -e "${WHITE}2. Increase Contrast:${NC}   $([ "$INCREASE_CONTRAST" = "1" ] && echo -e "${GREEN}ON${NC}" || echo -e "${RED}OFF${NC}")"
    echo -e "${WHITE}3. Button Shapes:${NC}       $([ "$BUTTON_SHAPES" = "1" ] && echo -e "${GREEN}ON${NC}" || echo -e "${RED}OFF${NC}")"
    echo -e "${WHITE}4. Beta Blur Effect:${NC}    $([ "$MORAEA_BLUR" = "1" ] && echo -e "${GREEN}ON${NC}" || echo -e "${RED}OFF${NC}")"
    echo -e "${WHITE}5. Appearance Mode:${NC}     $([ "$DARK_MODE" = "Dark" ] && echo -e "${BLUE}Dark${NC}" || echo -e "${YELLOW}Light${NC}")"
    echo ""
}

# Function to apply changes and restart services
apply_changes() {
    echo -e "${YELLOW}Applying changes...${NC}"
    killall Dock >/dev/null 2>&1
    killall SystemUIServer >/dev/null 2>&1
    echo -e "${GREEN}✓ Basic changes applied!${NC}"
    echo -e "${YELLOW}Note: For full effect, you may need to logout/login${NC}"
    sleep 2
}

# Function to apply changes with logout
apply_changes_with_logout() {
    echo -e "${YELLOW}Applying changes...${NC}"
    killall Dock >/dev/null 2>&1
    killall SystemUIServer >/dev/null 2>&1
    echo -e "${GREEN}✓ Changes applied!${NC}"
    echo -e "${YELLOW}Logging out in 5 seconds to fully apply transparency changes...${NC}"
    echo -e "${RED}Press Ctrl+C to cancel logout${NC}"
    
    for i in {5..1}; do
        echo -e "${BOLD}${RED}Logout in $i seconds...${NC}"
        sleep 1
    done
    
    echo -e "${GREEN}Logging out now...${NC}"
    osascript -e 'tell app "System Events" to log out'
}

# Preset configurations
apply_preset() {
    case $1 in
        1)
            echo -e "${MAGENTA}Applying Full Transparency (Default macOS)...${NC}"
            defaults write com.apple.universalaccess reduceTransparency -bool false
            defaults write com.apple.universalaccess increaseContrast -bool false
            defaults write com.apple.universalaccess buttonShapes -bool false
            defaults write NSGlobalDomain Moraea_BlurBeta -int 1
            ;;
        2)
            echo -e "${MAGENTA}Applying 25% Less Transparency (Recommended)...${NC}"
            defaults write com.apple.universalaccess reduceTransparency -bool false
            defaults write com.apple.universalaccess increaseContrast -bool true
            defaults write com.apple.universalaccess buttonShapes -bool false
            defaults write NSGlobalDomain Moraea_BlurBeta -int 0
            ;;
        3)
            echo -e "${MAGENTA}Applying 50% Less Transparency...${NC}"
            defaults write com.apple.universalaccess reduceTransparency -bool false
            defaults write com.apple.universalaccess increaseContrast -bool true
            defaults write com.apple.universalaccess buttonShapes -bool true
            defaults write NSGlobalDomain Moraea_BlurBeta -int 0
            ;;
        4)
            echo -e "${MAGENTA}Applying No Transparency (Accessibility)...${NC}"
            defaults write com.apple.universalaccess reduceTransparency -bool true
            defaults write com.apple.universalaccess increaseContrast -bool true
            defaults write com.apple.universalaccess buttonShapes -bool true
            defaults write NSGlobalDomain Moraea_BlurBeta -int 0
            ;;
    esac
    apply_changes
}

# Function to toggle individual settings
toggle_setting() {
    case $1 in
        1)
            if [ "$REDUCE_TRANSPARENCY" = "1" ]; then
                defaults write com.apple.universalaccess reduceTransparency -bool false
                echo -e "${GREEN}✓ Reduce Transparency: OFF${NC}"
            else
                defaults write com.apple.universalaccess reduceTransparency -bool true
                echo -e "${GREEN}✓ Reduce Transparency: ON${NC}"
            fi
            ;;
        2)
            if [ "$INCREASE_CONTRAST" = "1" ]; then
                defaults write com.apple.universalaccess increaseContrast -bool false
                echo -e "${GREEN}✓ Increase Contrast: OFF${NC}"
            else
                defaults write com.apple.universalaccess increaseContrast -bool true
                echo -e "${GREEN}✓ Increase Contrast: ON${NC}"
            fi
            ;;
        3)
            if [ "$BUTTON_SHAPES" = "1" ]; then
                defaults write com.apple.universalaccess buttonShapes -bool false
                echo -e "${GREEN}✓ Button Shapes: OFF${NC}"
            else
                defaults write com.apple.universalaccess buttonShapes -bool true
                echo -e "${GREEN}✓ Button Shapes: ON${NC}"
            fi
            ;;
        4)
            if [ "$MORAEA_BLUR" = "1" ]; then
                defaults write NSGlobalDomain Moraea_BlurBeta -int 0
                echo -e "${GREEN}✓ Beta Blur Effect: OFF${NC}"
            else
                defaults write NSGlobalDomain Moraea_BlurBeta -int 1
                echo -e "${GREEN}✓ Beta Blur Effect: ON${NC}"
            fi
            ;;
        5)
            if [ "$DARK_MODE" = "Dark" ]; then
                defaults write NSGlobalDomain AppleInterfaceStyle Light
                echo -e "${GREEN}✓ Switched to Light Mode${NC}"
            else
                defaults write NSGlobalDomain AppleInterfaceStyle Dark
                echo -e "${GREEN}✓ Switched to Dark Mode${NC}"
            fi
            ;;
    esac
    apply_changes
}

# Main menu function
show_menu() {
    clear
    echo -e "${BOLD}${BLUE}"
    echo "┌─────────────────────────────────────────────┐"
    echo "│        macOS Transparency Controller        │"
    echo "└─────────────────────────────────────────────┘"
    echo -e "${NC}"
    
    show_current_settings
    
    echo -e "${BOLD}${WHITE}Quick Presets:${NC}"
    echo -e "${CYAN}p1${NC}) Full Transparency (Default)"
    echo -e "${CYAN}p2${NC}) 25% Less Transparency ${GREEN}(Recommended)${NC}"
    echo -e "${CYAN}p3${NC}) 50% Less Transparency"
    echo -e "${CYAN}p4${NC}) No Transparency (Accessibility)"
    echo ""
    
    echo -e "${BOLD}${WHITE}Individual Settings:${NC}"
    echo -e "${CYAN}1${NC}) Toggle Reduce Transparency"
    echo -e "${CYAN}2${NC}) Toggle Increase Contrast"
    echo -e "${CYAN}3${NC}) Toggle Button Shapes"
    echo -e "${CYAN}4${NC}) Toggle Beta Blur Effect"
    echo -e "${CYAN}5${NC}) Toggle Dark/Light Mode"
    echo ""
    
    echo -e "${BOLD}${WHITE}Actions:${NC}"
    echo -e "${CYAN}r${NC}) Refresh/Show current settings"
    echo -e "${CYAN}a${NC}) Apply changes & restart UI"
    echo -e "${CYAN}l${NC}) Apply changes & ${RED}LOGOUT${NC} ${YELLOW}(Recommended)${NC}"
    echo -e "${CYAN}q${NC}) Quit"
    echo ""
    echo -e -n "${BOLD}Choose an option: ${NC}"
}

# Main script loop
main() {
    while true; do
        show_menu
        read choice
        
        case $choice in
            p1|P1) apply_preset 1 ;;
            p2|P2) apply_preset 2 ;;
            p3|P3) apply_preset 3 ;;
            p4|P4) apply_preset 4 ;;
            1) toggle_setting 1 ;;
            2) toggle_setting 2 ;;
            3) toggle_setting 3 ;;
            4) toggle_setting 4 ;;
            5) toggle_setting 5 ;;
            r|R) 
                echo -e "${GREEN}Refreshing settings...${NC}"
                sleep 1
                ;;
            a|A) 
                apply_changes 
                ;;
            l|L) 
                apply_changes_with_logout 
                ;;
            q|Q) 
                echo -e "${GREEN}Goodbye!${NC}"
                exit 0 
                ;;
            *) 
                echo -e "${RED}Invalid option. Press Enter to continue...${NC}"
                read
                ;;
        esac
    done
}

# Check if running on macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
    echo -e "${RED}Error: This script is designed for macOS only.${NC}"
    exit 1
fi

# Run the main script
main

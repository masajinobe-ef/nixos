#!/usr/bin/env bash
set -euo pipefail

# Color codes for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Define directories and files
SOPS_DIR="users/masa/sops"
AGE_KEY_FILE="$HOME/.config/sops/age/keys.txt"
TEMP_FILE="" # Initialize TEMP_FILE to avoid unbound variable error

# Create necessary directories
mkdir -p "$SOPS_DIR" "$(dirname "$AGE_KEY_FILE")"

# Check if the AGE key file exists; if not, generate new keys
if [ ! -f "$AGE_KEY_FILE" ]; then
    echo -e "${YELLOW}🔑 Generating new age keys...${NC}"
    age-keygen -o "$AGE_KEY_FILE"
    echo -e "${GREEN}✅ New age keys generated successfully!${NC}"
else
    echo -e "${GREEN}🔑 AGE key file already exists. Using existing keys.${NC}"
fi

# Extract the public key from the AGE key file
PUBKEY=$(grep "public key:" "$AGE_KEY_FILE" | awk '{print $NF}')
if [ -z "$PUBKEY" ]; then
    echo -e "${RED}❌ Error: Failed to get public key from $AGE_KEY_FILE${NC}" >&2
    exit 1
fi

# Create the SOPS configuration file
cat >"$SOPS_DIR/.sops.yaml" <<EOF
creation_rules:
  - path_regex: secrets.yaml$
    age: "$PUBKEY"
    encrypted_regex: ^(.*)$
EOF
echo -e "${GREEN}📄 SOPS configuration file created at: $SOPS_DIR/.sops.yaml${NC}"

# Function to add a key-value pair to the secrets.yaml file if it doesn't already exist
add_secret() {
    local key="$1"
    local value="$2"
    if ! grep -q "^$key: " "$SOPS_DIR/secrets.yaml"; then
        echo "$key: \"$value\"" >>"$SOPS_DIR/secrets.yaml"
        echo -e "${GREEN}✅ Added $key to secrets.yaml${NC}"
    else
        echo -e "${YELLOW}⚠️ $key already exists in secrets.yaml. Skipping...${NC}"
    fi
}

# Check if the secrets.yaml file exists and is empty
if [ ! -s "$SOPS_DIR/secrets.yaml" ]; then
    echo -e "${YELLOW}📝 Creating initial secrets template...${NC}"
    cat >"$SOPS_DIR/secrets.yaml" <<EOF
sing-box-uuid: "REPLACE_ME"
sing-box-public-key: "REPLACE_ME"
sing-box-short-id: "REPLACE_ME"
EOF

    # Encrypt the secrets file using SOPS
    TEMP_FILE="$SOPS_DIR/secrets.yaml.tmp"
    sops --config "$SOPS_DIR/.sops.yaml" \
        --encrypt "$SOPS_DIR/secrets.yaml" \
        >"$TEMP_FILE"

    mv "$TEMP_FILE" "$SOPS_DIR/secrets.yaml"
    echo -e "${GREEN}🔒 Initial secrets template created and encrypted successfully!${NC}"
else
    echo -e "${GREEN}📄 Secrets file already exists. Adding new entries...${NC}"
fi

# Prompt the user to edit the secrets file
echo -e "${GREEN}✏️ Press any key to edit secrets...${NC}"
read -r -n 1 -s

# Open the secrets file with SOPS for editing
sops --config "$SOPS_DIR/.sops.yaml" "$SOPS_DIR/secrets.yaml"

# Clean up temporary files if they exist
if [ -n "$TEMP_FILE" ] && [ -f "$TEMP_FILE" ]; then
    rm -f "$TEMP_FILE"
fi

# Display the locations of the generated files
echo -e "${GREEN}🔍 Secrets file located at: $SOPS_DIR/secrets.yaml${NC}"
echo -e "${GREEN}📁 SOPS configuration file located at: $SOPS_DIR/.sops.yaml${NC}"
echo -e "${GREEN}🔑 AGE key file located at: $AGE_KEY_FILE${NC}"

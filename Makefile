# Makefile for installing aliyun-ask plugin
# 安装目标目录，默认为 ~/.claude/
INSTALL_DIR ?= $(HOME)/.claude

# 定义源目录和目标目录
# SRC_AGENTS := $(CURDIR)/agents
# SRC_COMMANDS := $(CURDIR)/commands
SRC_SKILLS := $(CURDIR)/aliyun-ask

# DST_AGENTS := $(INSTALL_DIR)/agents
# DST_COMMANDS := $(INSTALL_DIR)/commands
DST_SKILLS := $(INSTALL_DIR)/skills

.PHONY: install help uninstall

# 默认目标
help:
	@echo "aliyun-ask Plugin Installation"
	@echo "=============================="
	@echo ""
	@echo "Available targets:"
	@echo "  make install           - Install plugin to ~/.claude/ (default)"
	@echo "  make install INSTALL_DIR=/custom/path - Install to custom directory"
	@echo "  make uninstall         - Remove installed plugin files"
	@echo "  make help              - Show this help message"
	@echo ""
	@echo "Current install directory: $(INSTALL_DIR)"

# 安装目标
install:
	@echo "Installing aliyun-ask plugin..."
	@echo "Target directory: $(INSTALL_DIR)"
	@echo ""

	# 创建目标目录（如果不存在）
# 	@mkdir -p $(DST_AGENTS)
# 	@mkdir -p $(DST_COMMANDS)
	@mkdir -p $(DST_SKILLS)

	# 复制 agents 目录内容
# 	@if [ -d "$(SRC_AGENTS)" ]; then \
# 		echo "Copying agents..."; \
# 		cp -R $(SRC_AGENTS)/* $(DST_AGENTS)/; \
# 	fi

	# 复制 commands 目录内容
# 	@if [ -d "$(SRC_COMMANDS)" ]; then \
# 		echo "Copying commands..."; \
# 		cp -R $(SRC_COMMANDS)/* $(DST_COMMANDS)/; \
# 	fi

	# 复制 skills 目录内容
	@if [ -d "$(SRC_SKILLS)" ]; then \
		echo "Copying skills..."; \
		cp -R $(SRC_SKILLS) $(DST_SKILLS)/; \
	fi

	@echo ""
	@echo "✓ Installation completed successfully!"
	@echo "Plugin installed to: $(INSTALL_DIR)"

# 卸载目标（可选）
uninstall:
	@echo "Uninstalling aliyun-ask plugin..."
	@echo "From directory: $(INSTALL_DIR)"
	@echo ""

	# 删除 agents 相关文件
# 	@if [ -d "$(SRC_AGENTS)" ]; then \
# 		echo "Removing agents..."; \
# 		for file in $(SRC_AGENTS)/*; do \
# 			if [ -f "$$file" ] || [ -d "$$file" ]; then \
# 				rm -rf $(DST_AGENTS)/$$(basename "$$file"); \
# 			fi; \
# 		done; \
# 	fi

	# 删除 commands 相关文件
# 	@if [ -d "$(SRC_COMMANDS)" ]; then \
# 		echo "Removing commands..."; \
# 		for file in $(SRC_COMMANDS)/*; do \
# 			if [ -f "$$file" ] || [ -d "$$file" ]; then \
# 				rm -rf $(DST_COMMANDS)/$$(basename "$$file"); \
# 			fi; \
# 		done; \
# 	fi

	# 删除 skills 相关文件
	@if [ -d "$(SRC_SKILLS)" ]; then \
		echo "Removing skills..."; \
		for file in $(SRC_SKILLS); do \
			if [ -f "$$file" ] || [ -d "$$file" ]; then \
				rm -rf $(DST_SKILLS)/aliyun-ask; \
			fi; \
		done; \
	fi

	@echo ""
	@echo "✓ Uninstallation completed!"

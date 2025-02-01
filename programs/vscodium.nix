{
  config,
  pkgs,
  ...
}: {
  # Configure VSCodium settings
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with pkgs.vscode-extensions; [
      ms-python.python
      ms-toolsai.jupyter
      esbenp.prettier-vscode
      asvetliakov.vscode-neovim
    ];
    userSettings = {
      "breadcrumbs.enabled" = false;
      "breadcrumbs.filePath" = "off";
      "breadcrumbs.showNumbers" = false;
      "debug.console.fontFamily" = "JetBrains Mono";
      "debug.console.fontSize" = 15;
      "debug.console.lineHeight" = 36;
      "debug.toolBarLocation" = "docked";
      "diffEditor.ignoreTrimWhitespace" = false;
      "diffEditor.renderSideBySide" = false;
      "editor.accessibilitySupport" = "off";
      "editor.bracketPairColorization.enabled" = false;
      "editor.codeLens" = false;
      "editor.colorDecorators" = false;
      "editor.cursorBlinking" = "phase";
      "editor.cursorStyle" = "block";
      "editor.folding" = false;
      "editor.foldingHighlight" = false;
      "editor.fontFamily" = "'IosevkaTerm Nerd Font'";
      "editor.fontLigatures" = true;
      "editor.fontSize" = 20;
      "editor.formatOnSave" = true;
      "editor.glyphMargin" = false;
      "editor.gotoLocation.multipleDeclarations" = "goto";
      "editor.gotoLocation.multipleDefinitions" = "goto";
      "editor.gotoLocation.multipleImplementations" = "goto";
      "editor.gotoLocation.multipleReferences" = "goto";
      "editor.gotoLocation.multipleTypeDefinitions" = "goto";
      "editor.guides.indentation" = false;
      "editor.hideCursorInOverviewRuler" = true;
      "editor.lineNumbers" = "on";
      "editor.matchBrackets" = "near";
      "editor.minimap.enabled" = false;
      "editor.minimap.renderCharacters" = false;
      "editor.overviewRulerBorder" = false;
      "editor.renderLineHighlight" = "none";
      "editor.renderWhitespace" = "none";
      "editor.scrollbar.horizontal" = "hidden";
      "editor.scrollbar.verticalScrollbarSize" = 8;
      "editor.showFoldingControls" = "never";
      "editor.wordWrap" = "on";
      "explorer.confirmDelete" = false;
      "explorer.confirmDragAndDrop" = false;
      "extensions.experimental.affinity" = {
        "asvetliakov.vscode-neovim" = 1;
      };
      "python.pythonPath" = "~/.local/python/bin";
      "python.defaultInterpreterPath" = "~/.local/python/bin/python";
      "git.confirmSync" = false;
      "git.enableSmartCommit" = true;
      "markdown.preview.markEditorSelection" = false;
      "outline.icons" = false;
      "outline.showNumbers" = false;
      "problems.decorations.enabled" = false;
      "scm.diffDecorations" = "none";
      "security.workspace.trust.banner" = "never";
      "security.workspace.trust.enabled" = false;
      "security.workspace.trust.untrustedFiles" = "open";
      "window.autoDetectColorScheme" = true;
      "window.autoDetectHighContrast" = false;
      "window.closeWhenEmpty" = true;
      "window.commandCenter" = true;
      "window.customTitleBarVisibility" = "auto";
      "window.enableMenuBarMnemonics" = false;
      "window.newWindowDimensions" = "inherit";
      "window.title" = "''\${rootName}";
      "window.titleBarStyle" = "custom";
      "workbench.activityBar.location" = "top";
      "workbench.editor.decorations.badges" = false;
      "workbench.editor.decorations.colors" = false;
      "workbench.editor.enablePreview" = false;
      "workbench.editor.languageDetection" = false;
      "workbench.editor.languageDetectionHints.untitledEditors" = false;
      "workbench.editor.languageDetectionHints.notebookEditors" = false;
      "workbench.editor.revealIfOpen" = true;
      "workbench.editor.showIcons" = false;
      "workbench.editor.showTabs" = "single";
      "workbench.editor.tabSizing" = "shrink";
      "workbench.iconTheme" = null;
      "workbench.layoutControl.enabled" = false;
      "workbench.list.horizontalScrolling" = true;
      "workbench.preferredDarkColorTheme" = "Adwaita Dark";
      "workbench.preferredLightColorTheme" = "Adwaita Light";
      "workbench.productIconTheme" = "adwaita";
      "workbench.settings.enableNaturalLanguageSearch" = false;
      "workbench.sideBar.location" = "right";
      "workbench.startupEditor" = "none";
      "workbench.statusBar.visible" = false;
      "workbench.tips.enabled" = false;
      "workbench.tree.indent" = 12;
      "workbench.tree.renderIndentGuides" = "none";
      "explorer.fileNesting.enabled" = true;
      "explorer.decorations.badges" = false;
      "explorer.decorations.colors" = false;
      "git.openRepositoryInParentFolders" = "always";
    };
  };
}

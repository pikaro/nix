{...}: {
  # Copy a file instead of linking it
  copyFile = sourcePath: targetPath: {
    source = sourcePath;
    onChange = ''
      rm -f "${targetPath}"
      rsync -a ''$(realpath "${sourcePath}") "${targetPath}"
    '';
  };
}

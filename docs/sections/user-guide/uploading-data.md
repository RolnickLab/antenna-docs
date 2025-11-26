# Uploading data

## Configuring a data source

### Demo

<iframe allowfullscreen class="video" src="https://drive.google.com/file/d/1pnUeMtSXcA-aC7G7JiHDwW5gaGPeG6dl/preview"></iframe>

## Image requirements

Valid image formats are PNG, GIF and JPEG. Image filenames must contain a timestamp with year, month, day, hours, minutes and seconds (e.g. 20210101120000-snapshot.jpg). The timestamp in the filename makes it possible to do fast indexing of files, which is helpful when reading a large amount of images from a remote storage.

## Renaming images

If images filenames are not matching the requirements, the images have to be renamed before being uploaded. To automate this process, we recommend [this Python utility](https://github.com/mihow/ami-camera-utils) that renames image files based on their EXIF timestamp data. The script can recursively scan directories and renames files using the format `prefix-YYYYMMDDHHmmSS.ext`.

### Install the utility

First, download and install [Python](https://www.python.org/). Then try this command to make sure the installation was successful.

```bash
python --version
```

Next, install the utility.

```bash
pip install https://github.com/mihow/ami-camera-utils/archive/refs/heads/main.zip
pip install --upgrade typer
```

Then try this command to make sure the installation was successful.

```bash
photo-renamer --help
```

### Use the utility

To rename photos in a folder, use this command. Replace the dummy path with the directory containing images to rename. The script will show a confirmation prompt before proceeding.

```bash
photo-renamer "path/to/photos" --inplace
```

For more options, checkout the [utility documention](https://github.com/mihow/ami-camera-utils).

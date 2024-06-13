// user generated script
// credit to FrostyCat, https://forum.gamemaker.io/index.php?members/frostycat.1531/
// in : https://forum.gamemaker.io/index.php?threads/saving-ds_grid-using-json.81397/
function grid_to_struct(grid) {
    var width = ds_grid_width(grid);
    var height = ds_grid_height(grid);
    var arrays = array_create(height);
    for (var yy = height-1; yy >= 0; --yy) {
        var currentRow = array_create(width);
        for (var xx = width-1; xx >= 0; --xx) {
            currentRow[xx] = grid[# xx, yy];
        }
        arrays[yy] = currentRow;
    }
    return {
        width: width,
        height: height,
        data: arrays
    };
}

function struct_to_grid(strc) {
    var height = strc.height;
    var width = strc.width;
    var arrays = strc.data;
    var grid = ds_grid_create(width, height);
    for (var yy = height-1; yy >= 0; --yy) {
        var currentRow = arrays[yy];
        for (var xx = width-1; xx >= 0; --xx) {
            grid[# xx, yy] = currentRow[xx];
        }
    }
    return grid;
}
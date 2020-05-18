// $('table.tablesorter').tablesorter({
// });

$(function() {
    $("#example1").tablesorter({
        sortList: [[0,0]],
        // widgets: ["zebra"],
        headers: { 0: { sorter:"digit"}}
    })
    .tablesorterPager({
        container: $("#pager"),
        size: 25,
        positionFixed: false
    });
});
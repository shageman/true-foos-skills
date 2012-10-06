// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require __jquery.tablesorter/jquery.tablesorter.min
//= require chosen/chosen/chosen.jquery.min
//= require_tree .

$(function () {
    $("table").tablesorter();
    $("select").chosen();
});

$("[data-isplayer=true]").hover(
    function () {
        var highlight_player = $(this).data("player")
        $("[data-player='" + highlight_player + "']").addClass('highlight')
    },
    function () {
        var highlight_player = $(this).data("player")
        $("[data-player='" + highlight_player + "']").removeClass('highlight')
    }
)

$("#switch_black_players").on("click", function(e) {
    e.preventDefault()
    var back_player = $("#game_black_back_player_id").val()
    var front_player = $("#game_black_front_player_id").val()
    $("#game_black_back_player_id").val(front_player).trigger("liszt:updated")
    $("#game_black_front_player_id").val(back_player).trigger("liszt:updated")
})

$("#switch_yellow_players").on("click", function(e) {
    e.preventDefault()
    var back_player = $("#game_yellow_back_player_id").val()
    var front_player = $("#game_yellow_front_player_id").val()
    $("#game_yellow_back_player_id").val(front_player).trigger("liszt:updated")
    $("#game_yellow_front_player_id").val(back_player).trigger("liszt:updated")
})

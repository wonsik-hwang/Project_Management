/**
 * 
 */
$(document).ready(function(){
	
	
   /* $( ".sel_prj" ).change(function() {
		if(this.value== 86 || this.value== 32 ){
	    $(this).parent().find(".LeaveDiv").show();
		} else {
		$(this).parent().find(".LeaveDiv").hide();
		}

	});
	$( ".leaveCombo" ).change(function() {
		if(this.value== 06){
			$(this).parent().siblings(".LeaveTimeSpan").show();
		}else{
			$(this).parent().siblings(".LeaveTimeSpan").hide();
		}
		}); 
*/		
	
	var selectableHeader = "프로젝트 미참여 인원";
	var selectionHeader = "프로젝트 참여 인원";

	$(".referers").each(function(){
		$(this).multiSelect({
			  selectableHeader: "<div class='custom-header'>" + selectableHeader + "</div><input type='text' class='search-input' autocomplete='off' placeholder='이름을 입력해주세요'>",
			  selectionHeader: "<div class='custom-header'>" + selectionHeader + "</div><input type='text' class='search-input' autocomplete='off' placeholder='이름을 입력해주세요'>",
			  afterInit: function(ms){
			    var that = this,
			        $selectableSearch = that.$selectableUl.prev(),
			        $selectionSearch = that.$selectionUl.prev(),
			        selectableSearchString = '#'+that.$container.attr('id')+' .ms-elem-selectable:not(.ms-selected)',
			        selectionSearchString = '#'+that.$container.attr('id')+' .ms-elem-selection.ms-selected';

			    that.qs1 = $selectableSearch.quicksearch(selectableSearchString)
			    .on('keydown', function(e){
			      if (e.which === 40){
			        that.$selectableUl.focus();
			        return false;
			      }
			    });

			    that.qs2 = $selectionSearch.quicksearch(selectionSearchString)
			    .on('keydown', function(e){
			      if (e.which == 40){
			        that.$selectionUl.focus();
			        return false;
			      }
			    });
			  },
			  afterSelect: function(){
			    this.qs1.cache();
			    this.qs2.cache();
			  },
			  afterDeselect: function(){
			    this.qs1.cache();
			    this.qs2.cache();
			  }
		});
	});
});
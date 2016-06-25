<div class="modal assignTask">
	<div class="modal-dialog">
		<div class="modal-content">
			<form name="worklog" id="modalAssign" class="modalform">
				<input type="hidden" name="awprojectid" value="{$project}" />
				<input type="hidden" name="awtaskid" value="{$task}" />
				<input type="hidden" name="cl" value="tasklist" />
				<div class="modal-header">
					<button aria-label="Close" data-dismiss="modal" class="close" type="button"><span aria-hidden="true">×</span></button>
					<h4 class="modal-title">{awmultilang ident="CHANGESTATE"}</h4>
				</div>
				<div class="modal-body">
					<div class="form-group">
						<label for="awowner">{awmultilang ident="OWNER"}</label><br>
						<select name="awowner" class="form-control">
							<option value="0">{awmultilang ident="NOASSIGNEE"}</option>
							{foreach from=$oUser2Project item=aUser}
								<option value="{$aUser.awid}"{if $aUser.awid == $aTask.awowner} selected="selected"{/if}>{$oUser->getUserName($aUser.awid)}</option>
							{/foreach}
						</select>
					</div>
					
				</div>
				<div class="modal-footer">
					<button data-dismiss="modal" class="btn btn-default pull-left closebtn" type="button">{awmultilang ident="CLOSE"}</button>
					<button class="btn btn-primary" id="sendtimelog" type="submit">{awmultilang ident="SAVE"}</button>
				</div>
			</form>
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->

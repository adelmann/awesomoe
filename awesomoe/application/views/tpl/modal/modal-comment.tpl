<div class="modal comment">
	<div class="modal-dialog">
		<div class="modal-content">
			<form name="worklog" id="modalcomments" class="modalform">
				{if isset($oComments2Edit)}
					<input type="hidden" name="awprojectid" value="{$oComments2Edit.awprojectid}" />
					<input type="hidden" name="awtaskid" value="{$oComments2Edit.awtaskid}" />
					<input type="hidden" name="awid" value="{$oComments2Edit.awid}" />
					<input type="hidden" name="cl" value="comments" />
				{else}
					<input type="hidden" name="awprojectid" value="{$project}" />
					<input type="hidden" name="awtaskid" value="{$task}" />
					<input type="hidden" name="cl" value="comments" />
				{/if}
				<div class="modal-header">
					<button aria-label="Close" data-dismiss="modal" class="close" type="button"><span aria-hidden="true">×</span></button>
					<h4 class="modal-title">{awmultilang ident="COMMENT"}</h4>
				</div>
				<div class="modal-body">
					
					<div class="box-body">
						<div class="form-group">
							<label for="awdesc">{awmultilang ident="AWCOMMENTGDESC"}</label>
							<textarea id="awdesc" class="form-control texteditor required" name="awdesc">{if isset($oComments2Edit)}{$oComments2Edit.awdesc}{/if}</textarea>
						</div>
					</div><!-- /.box-body -->
				</div>
				<div class="modal-footer">
					<button data-dismiss="modal" class="btn btn-default pull-left closebtn" type="button">{awmultilang ident="CLOSE"}</button>
					<button class="btn btn-primary" id="" type="submit">{awmultilang ident="SAVE"}</button>
				</div>
				
			</form>
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->

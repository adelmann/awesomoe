<div class="modal timelog">
	<div class="modal-dialog">
		<div class="modal-content">
			<form name="worklog" id="modalworklog" class="modalform">
				{if isset($oWorklogs2Edit)}
					
					<input type="hidden" name="awprojectid" value="{$oWorklogs2Edit.awprojectid}" />
					<input type="hidden" name="awtaskid" value="{$oWorklogs2Edit.awtaskid}" />
					<input type="hidden" name="awid" value="{$oWorklogs2Edit.awid}" />
					<input type="hidden" name="awoldval" value="{$oWorklogs2Edit.awdesc}" />
					<input type="hidden" name="cl" value="worklog" />
				{else}
					<input type="hidden" name="awprojectid" value="{$project}" />
					<input type="hidden" name="awtaskid" value="{$task}" />
					<input type="hidden" name="cl" value="worklog" />
				{/if}
				<div class="modal-header">
					<button aria-label="Close" data-dismiss="modal" class="close" type="button"><span aria-hidden="true">×</span></button>
					<h4 class="modal-title">{awmultilang ident="WORKLOGFORM"}</h4>
				</div>
				<div class="modal-body">
					
					<div class="box-body">
						<div class="form-group">
							<label for="awdesc">{awmultilang ident="AWTIMELOGDESC"}</label>
							<textarea id="awdesc" class="form-control texteditor required" name="awdesc">{if isset($oWorklogs2Edit)}{$oWorklogs2Edit.awdesc}{/if}</textarea>
						</div>
					</div><!-- /.box-body -->
					<div class="bootstrap-timepicker">
						<div class="form-group">
						  <label>{awmultilang ident="TIME"}</label>
						  <div class="input-group">
							<input type="text" class="form-control timepicker required" name="awtime"{if isset($oWorklogs2Edit)} value="{$oWorklogs2Edit.awtime}"{/if}/>
							<div class="input-group-addon">
							  <i class="fa fa-clock-o"></i>
							</div>
						  </div><!-- /.input group -->
						</div><!-- /.form group -->
					</div>
				</div>
				<div class="modal-footer">
					<button data-dismiss="modal" class="btn btn-default pull-left closebtn" type="button">{awmultilang ident="CLOSE"}</button>
					<button class="btn btn-primary" id="" type="submit">{awmultilang ident="SAVE"}</button>
				</div>
			</form>
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->

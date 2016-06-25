{foreach from=$oWorklogs item=worklog}
	<div class="row">
		<div class="col-sm-12">
			{if $oUser->getUserAvatar($worklog.awuser)}
				<img src="media/profile/{$oUser->getUserAvatar($worklog.awuser)}" class="img-circle user-image-small" alt="{$oUser->getUserName($worklog.awuser)}">
				{$oUser->getUserName($worklog.awuser)} 
			{/if}
			{awmultilang ident="LOGGEDWORK"} {$worklog.awdate}
			{if $aActUser.awgroup == '1' || $worklog.awuser == $aActUser.awid}
				<div class="box-header">
					<div class="box-tools pull-right worklogactions">
						<div class="btn-group">
						  <button data-toggle="dropdown" class="btn btn-box-tool dropdown-toggle" aria-expanded="true"><i class="fa fa-wrench"></i></button>
						  <ul role="menu" class="dropdown-menu">
							<li><a class="fnc" id="edit-{$worklog.awid}">{awmultilang ident="EDIT"}</a></li>
							<li><a class="fnc" id="delete-{$worklog.awid}">{awmultilang ident="DELETETHISTASKLOG"}</a></li>
						  </ul>
						</div>
					</div>
				</div>
			{/if}
		</div>
		<div class="col-sm-2">
			{awmultilang ident="TIMESPENT"}
		</div>
		<div class="col-sm-10">
			{$worklog.awtime}<br>
			{$worklog.awdesc}
		</div>
		<div class="col-sm-12">
			<hr>
		</div>
	</div>
{/foreach}
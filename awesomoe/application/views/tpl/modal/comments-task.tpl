{foreach from=$oComments item=comment}
	<div class="row">
		<div class="col-sm-12">
			{$oUser->getUserName($comment.awuser)} {$comment.awdate}
			{if $aActUser.awgroup == '1' || $comment.awuser == $aActUser.awid}
				<div class="box-header">
					<div class="box-tools pull-right commentactions">
						<div class="btn-group">
						  <button data-toggle="dropdown" class="btn btn-box-tool dropdown-toggle" aria-expanded="true"><i class="fa fa-wrench"></i></button>
						  <ul role="menu" class="dropdown-menu">
							<li><a class="fnc" id="edit-{$comment.awid}">{awmultilang ident="EDIT"}</a></li>
							<li><a class="fnc" id="delete-{$comment.awid}">{awmultilang ident="DELETETHISTASK"}</a></li>
						  </ul>
						</div>
					</div>
				</div>
			{/if}
		</div>

		<div class="col-sm-10">

			{$comment.awdesc}
		</div>
		<div class="col-sm-12">
			<hr>
		</div>
	</div>
{/foreach}
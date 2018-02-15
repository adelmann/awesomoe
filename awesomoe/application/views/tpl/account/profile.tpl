{include file="tpl/header.tpl"}
{include file="tpl/sidebar.tpl"}
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
	<section class="content-header">
		<h1>
			Profile
		</h1>
		{include file="tpl/breadcrumb.tpl"}
	</section>
	<!-- Main content -->
	<section class="content">
		<div class="row">
			<div class="col-md-6">
				<div class="box box-solid">
					<div class="box-header with-border">
						<i class="fa fa-user"></i>
						<h3 class="box-title">{awmultilang ident="OVERVIEW"}</h3>
						<div class="box-tools pull-right">
                            <a class="btn btn-default" href="?cl=profile&fnc=edit"><i class="fa fa-edit"></i></a>
						</div>
					</div>
					
					<div class="box-body">
						
						<table class="table">
							<tbody>
								<tr>
								  <td class="text-right" style="width:150px;">{awmultilang ident="NAME"}</td>
								  <td>{$aActUser.awname} {$aActUser.awlastname}</td>
								</tr>
								<tr>
								  <td class="text-right">{awmultilang ident="MAIL"}</td>
								  <td>{$aActUser.awmail}</td>
								</tr>
								<tr>
								  <td class="text-right">{awmultilang ident="PHONE"}</td>
								  <td>{$aActUser.awphone}</td>
								</tr>
								<tr>
								  <td class="text-right">{awmultilang ident="MOBILE"}</td>
								  <td>{$aActUser.awmobile}</td>
								</tr>
								<tr>
								  <td class="text-right">{awmultilang ident="ZIP"} {awmultilang ident="AND"} {awmultilang ident="CITY"}</td>
								  <td>{$aActUser.awzip} {$aActUser.awcity}</td>
								</tr><tr>
								  <td class="text-right">{awmultilang ident="STREET"}</td>
								  <td>{$aActUser.awstreet}</td>
								</tr>
								<tr>
								  <td class="text-right">{awmultilang ident="COUNTRY"}</td>
								  <td>{$aActUser.awcountry}</td>
								</tr>
								<tr>
								  <td class="text-right">{awmultilang ident="COMPANY"}</td>
								  <td>{$aActUser.awcompany}</td>
								</tr>
								<tr>
								  <td class="text-right">{awmultilang ident="POSITION"}</td>
								  <td>{$aActUser.awposition}</td>
								</tr>
								<tr>
								  <td class="text-right">{awmultilang ident="GENDER"}</td>
								  <td>{$aActUser.awgender}</td>
								</tr>
								<tr>
								  <td class="text-right">{awmultilang ident="MEMBERSINCE"}</td>
								  <td>{$aActUser.awadded}</td>
								</tr>
							</tbody>
						</table>
					
					</div>
				</div>
            </div>
            <div class="col-md-6">
                <div class="box box-solid">
                    <div class="box-header with-border">
                        <h3 class="box-title">{awmultilang ident="AVATAR"}</h3>
                        <div class="box-tools pull-right">
                            <a class="btn btn-default" href="?cl=profile&fnc=editavatar"><i class="fa fa-edit"></i></a>
                        </div>
                    </div>
                    <div class="box-body text-center">
                        {if $oUser->getUserAvatar($aActUser.awid)}
                            <img src="{$mediadir}/profile/{$oUser->getUserAvatar($aActUser.awid)}" class="img-circle" alt="User Image" />
                        {else}
                            {awmultilang ident="NOVATAR"}
                        {/if}
                    </div>
                </div>
            </div>
			<div class="col-md-6">
				<div class="box box-solid">
					<div class="box-header with-border">
						<h3 class="box-title">{awmultilang ident="ACTIVITY"}</h3>
					</div>
					<div class="box-body text-center">
                  
					</div>
				</div>
            </div>
		</div>
		<div class="row">
			<div class="col-md-6">
				<div class="box box-solid">
					<div class="box-header with-border">
						<h3 class="box-title">{awmultilang ident="PROJECTS"}</h3>
					</div>
				</div>
			</div>
		</div>
	</section><!-- /.content -->
</div><!-- /.content-wrapper -->
{include file="tpl/footer.tpl"}
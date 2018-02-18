{include file="tpl/header.tpl"}
{include file="tpl/sidebar.tpl"}
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
	<section class="content-header">
		<h1>
			{awmultilang ident="PROFILE"} - {awmultilang ident="EDIT"}
		</h1>
		{include file="tpl/breadcrumb.tpl"}
	</section>
	<!-- Main content -->
	<section class="content">
		<div class="row">
			<div class="col-md-12">
				<div class="box box-solid">
					<div class="box-header with-border">
						<i class="fa fa-user"></i>
						<h3 class="box-title">{awmultilang ident="PROFILE"} {awmultilang ident="EDIT"}</h3>
					</div>
					<form role="form" action="index.php" method="POST">
						<input type="hidden" name="cl" value="profile">
						<input type="hidden" name="fnc" value="save">
						<input type="hidden" name="awid" value="{$aActUser.awid}">
						<div class="box-body">
							<div class="form-group">
								<label for="name">{awmultilang ident="PRENAME"}</label>
								<input type="text" placeholder="Vorname" id="name" class="form-control" name="awname" value="{$aActUser.awname}">
							</div>
							<div class="form-group">
								<label for="lastname">{awmultilang ident="LASTNAME"}</label>
								<input type="text" placeholder="Nachname" id="lastname" class="form-control" name="awlastname" value="{$aActUser.awlastname}">
							</div>
							<div class="form-group">
								<label for="gender">{awmultilang ident="GENDER"}</label>
								<div class="input-group">
									<div class="input-group-addon">
										<i class="fa fa-male"></i>
										<i class="fa fa-female"></i>
									</div>
									<select class="form-control" name="awgender">
										<option value="1"{if $aActUser.awgender == '1'} selected="selected"{/if}>{awmultilang ident="MALE"}</option>
										<option value="2"{if $aActUser.awgender == '2'} selected="selected"{/if}>{awmultilang ident="FEMALE"}</option>
										<option value="3"{if $aActUser.awgender == '0' || empty($aActUser.awgender)} selected="selected"{/if}>{awmultilang ident="NOTSETTED"}</option>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label for="email">{awmultilang ident="MAIL"}</label>
								<div class="input-group">
									<div class="input-group-addon">
										<i class="fa fa-envelope"></i>
									</div>
									<input type="email" placeholder="{awmultilang ident="MAIL"}" id="email" class="form-control" name="awmail" value="{$aActUser.awmail}">
								</div>
							</div>
							<div class="form-group">
								<label for="phone">{awmultilang ident="PHONE"}</label>
								<div class="input-group">
									<div class="input-group-addon">
										<i class="fa fa-phone"></i>
									</div>
									<input type="text" class="form-control" name="awphone" value="{$aActUser.awphone}" id="phone" >
								</div>
							</div>
							<div class="form-group">
								<label for="mobile">{awmultilang ident="MOBILE"}</label>
								<div class="input-group">
									<div class="input-group-addon">
										<i class="fa fa-phone"></i>
									</div>
									<input type="text" placeholder="{awmultilang ident="MOBILE"}" id="mobile" class="form-control" name="awmobile" value="{$aActUser.awmobile}" data-mask="" data-inputmask="&quot;mask&quot;: &quot;(999) 999-9999&quot;">
								</div>
							</div>

                            <div class="form-group">
                                <label for="mobile">{awmultilang ident="URL"}</label>
                                <div class="input-group">
                                    <div class="input-group-addon">
                                        <i class="fa fa-home"></i>
                                    </div>
                                    <input type="text" placeholder="{awmultilang ident="http://www."}" class="form-control" name="awurl" value="{$aActUser.awurl}">
                                </div>
                            </div>
							
							<div class="row">
								<div class="col-xs-12"><label>{awmultilang ident="ZIP"} {awmultilang ident="AND"} {awmultilang ident="CITY"}</label></div>
								<div class="col-xs-2">
									<input type="text" placeholder="{awmultilang ident="ZIP"}" class="form-control" name="awzip" value="{$aActUser.awzip}">
								</div>
								<div class="col-xs-10">
									<input type="text" placeholder="{awmultilang ident="CITY"}" class="form-control" name="awcity" value="{$aActUser.awcity}">
								</div>
								<div class="col-xs-12">&nbsp;</div>
							</div>
							<div class="form-group">
								<label for="mobile">{awmultilang ident="STREET"} {awmultilang ident="AND"} {awmultilang ident="BUILDINGNR"}</label>
								<input type="text" placeholder="Straße" id="mobile" class="form-control" name="awstreet" value="{$aActUser.awstreet}">
							</div>
							<div class="form-group">
								<label for="country">{awmultilang ident="COUNTRY"}</label>
								<select class="form-control" name="awcountry">
									<option value="1"{if $aActUser.awcountry == '1'} selected="selected"{/if}>{awmultilang ident="GERMANY"}</option>
									<option value="2"{if $aActUser.awcountry == '2'} selected="selected"{/if}>{awmultilang ident="AUSTRIA"}</option>
									<option value="3"{if $aActUser.awcountry == '3'} selected="selected"{/if}>{awmultilang ident="SWISS"}</option>
									<option value="4"{if $aActUser.awcountry == '4'} selected="selected"{/if}>{awmultilang ident="FRANCE"}</option>
									<option value="5"{if $aActUser.awcountry == '5'} selected="selected"{/if}>{awmultilang ident="SPAIN"}</option>
									<option value="6"{if $aActUser.awcountry == '7'} selected="selected"{/if}>{awmultilang ident="UNITEDKINGDOM"}</option>
									<option value="7"{if $aActUser.awcountry == '0' || empty($aActUser.awcountry)} selected="selected"{/if}>{awmultilang ident="NOTSETTED"}</option>
								</select>
							</div>
							
							<div class="form-group">
								<label for="awnotification2comment">{awmultilang ident="NOTIFICATION2COMMENT"}</label>
								<select class="form-control" name="awnotification2comment">
									<option value="0"{if $aActUser.awnotification2comment == '0'} selected="selected"{/if}>{awmultilang ident="NONOTIFICATION"}</option>
									<option value="1"{if $aActUser.awnotification2comment == '1'} selected="selected"{/if}>{awmultilang ident="ONLYONSITENOTIFICATION"}</option>
									<option value="2"{if $aActUser.awnotification2comment == '2'} selected="selected"{/if}>{awmultilang ident="ONLYMAILNOTIFICATION"}</option>
									<option value="3"{if $aActUser.awnotification2comment == '3'} selected="selected"{/if}>{awmultilang ident="ALLNOTIFICATION"}</option>
								</select>
								
								<label for="awnotification2worklog">{awmultilang ident="NOTIFICATION2WORKLOG"}</label>
								<select class="form-control" name="awnotification2worklog">
									<option value="0"{if $aActUser.awnotification2worklog == '0'} selected="selected"{/if}>{awmultilang ident="NONOTIFICATION"}</option>
									<option value="1"{if $aActUser.awnotification2worklog == '1'} selected="selected"{/if}>{awmultilang ident="ONLYONSITENOTIFICATION"}</option>
									<option value="2"{if $aActUser.awnotification2worklog == '2'} selected="selected"{/if}>{awmultilang ident="ONLYMAILNOTIFICATION"}</option>
									<option value="3"{if $aActUser.awnotification2worklog == '3'} selected="selected"{/if}>{awmultilang ident="ALLNOTIFICATION"}</option>
								</select>
								
								<label for="awnotification2state">{awmultilang ident="NOTIFICATION2STATE"}</label>
								<select class="form-control" name="awnotification2state">
									<option value="0"{if $aActUser.awnotification2state == '0'} selected="selected"{/if}>{awmultilang ident="NONOTIFICATION"}</option>
									<option value="1"{if $aActUser.awnotification2state == '1'} selected="selected"{/if}>{awmultilang ident="ONLYONSITENOTIFICATION"}</option>
									<option value="2"{if $aActUser.awnotification2state == '2'} selected="selected"{/if}>{awmultilang ident="ONLYMAILNOTIFICATION"}</option>
									<option value="3"{if $aActUser.awnotification2state == '3'} selected="selected"{/if}>{awmultilang ident="ALLNOTIFICATION"}</option>
								</select>
								
								<label for="awnotification2description">{awmultilang ident="NOTIFICATION2DESCRIPTION"}</label>
								<select class="form-control" name="awnotification2description">
									<option value="0"{if $aActUser.awnotification2description == '0'} selected="selected"{/if}>{awmultilang ident="NONOTIFICATION"}</option>
									<option value="1"{if $aActUser.awnotification2description == '1'} selected="selected"{/if}>{awmultilang ident="ONLYONSITENOTIFICATION"}</option>
									<option value="2"{if $aActUser.awnotification2description == '2'} selected="selected"{/if}>{awmultilang ident="ONLYMAILNOTIFICATION"}</option>
									<option value="3"{if $aActUser.awnotification2description == '3'} selected="selected"{/if}>{awmultilang ident="ALLNOTIFICATION"}</option>
								</select>
								
								<label for="awnotification2assignee">{awmultilang ident="NOTIFICATION2ASSIGNEE"}</label>
								<select class="form-control" name="awnotification2assignee">
									<option value="0"{if $aActUser.awnotification2assignee == '0'} selected="selected"{/if}>{awmultilang ident="NONOTIFICATION"}</option>
									<option value="1"{if $aActUser.awnotification2assignee == '1'} selected="selected"{/if}>{awmultilang ident="ONLYONSITENOTIFICATION"}</option>
									<option value="2"{if $aActUser.awnotification2assignee == '2'} selected="selected"{/if}>{awmultilang ident="ONLYMAILNOTIFICATION"}</option>
									<option value="3"{if $aActUser.awnotification2assignee == '3'} selected="selected"{/if}>{awmultilang ident="ALLNOTIFICATION"}</option>
								</select>
								
								<label for="awnotification2newtask">{awmultilang ident="NOTIFICATION2NEWTASK"}</label>
								<select class="form-control" name="awnotification2newtask">
									<option value="0"{if $aActUser.awnotification2newtask == '0'} selected="selected"{/if}>{awmultilang ident="NONOTIFICATION"}</option>
									<option value="1"{if $aActUser.awnotification2newtask == '1'} selected="selected"{/if}>{awmultilang ident="ONLYONSITENOTIFICATION"}</option>
									<option value="2"{if $aActUser.awnotification2newtask == '2'} selected="selected"{/if}>{awmultilang ident="ONLYMAILNOTIFICATION"}</option>
									<option value="3"{if $aActUser.awnotification2newtask == '3'} selected="selected"{/if}>{awmultilang ident="ALLNOTIFICATION"}</option>
								</select>
							</div>
						</div><!-- /.box-body -->

						<div class="box-footer">
							<button class="btn btn-primary" type="submit">{awmultilang ident="SAVE"}</button>
							<a class="btn btn-default" href="index.php?cl=profile">{awmultilang ident="CANCEL"}</a>
						</div>
					</form>
				</div>
            </div>
			
			
		</div>
	</section><!-- /.content -->
</div><!-- /.content-wrapper -->
{include file="tpl/footer.tpl"}
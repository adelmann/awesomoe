{include file="tpl/header.tpl"}
{include file="tpl/sidebar.tpl"}
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
	<section class="content-header">
		<h1>
			{awmultilang ident="PROFILE"} - {awmultilang ident="ADD"}
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
						<input type="hidden" name="cl" value="users">
						<input type="hidden" name="fnc" value="add">
						<input type="hidden" name="awid" value="-1">
						<div class="box-body">
							<div class="form-group">
								<label for="name">{awmultilang ident="PRENAME"}</label>
								<input type="text" placeholder="Vorname" id="name" class="form-control" name="awname" value="">
							</div>
							<div class="form-group">
								<label for="lastname">{awmultilang ident="LASTNAME"}</label>
								<input type="text" placeholder="Nachname" id="lastname" class="form-control" name="awlastname" value="">
							</div>
							<div class="form-group">
								<label for="gender">{awmultilang ident="GENDER"}</label>
								<div class="input-group">
									<div class="input-group-addon">
										<i class="fa fa-male"></i>
										<i class="fa fa-female"></i>
									</div>
									<select class="form-control" name="awgender">
										<option value="1">{awmultilang ident="MALE"}</option>
										<option value="2">{awmultilang ident="FEMALE"}</option>
										<option value="3">{awmultilang ident="NOTSETTED"}</option>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label for="email">{awmultilang ident="MAIL"}</label>
								<div class="input-group">
									<div class="input-group-addon">
										<i class="fa fa-envelope"></i>
									</div>
									<input type="email" placeholder="{awmultilang ident="MAIL"}" id="email" class="form-control" name="awmail" value="">
								</div>
							</div>
							<div class="form-group">
								<label for="phone">{awmultilang ident="PHONE"}</label>
								<div class="input-group">
									<div class="input-group-addon">
										<i class="fa fa-phone"></i>
									</div>
									<input type="text" class="form-control" name="awphone" value="" id="phone" >
								</div>
							</div>
							<div class="form-group">
								<label for="mobile">{awmultilang ident="MOBILE"}</label>
								<div class="input-group">
									<div class="input-group-addon">
										<i class="fa fa-phone"></i>
									</div>
									<input type="text" placeholder="{awmultilang ident="MOBILE"}" id="mobile" class="form-control" name="awmobile" value="" data-mask="" data-inputmask="&quot;mask&quot;: &quot;(999) 999-9999&quot;">
								</div>
							</div>

                            <div class="form-group">
                                <label for="mobile">{awmultilang ident="URL"}</label>
                                <div class="input-group">
                                    <div class="input-group-addon">
                                        <i class="fa fa-home"></i>
                                    </div>
                                    <input type="text" placeholder="{awmultilang ident="http://www."}" class="form-control" name="awurl" value="">
                                </div>
                            </div>
							
							<div class="row">
								<div class="col-xs-12"><label>{awmultilang ident="ZIP"} {awmultilang ident="AND"} {awmultilang ident="CITY"}</label></div>
								<div class="col-xs-2">
									<input type="text" placeholder="{awmultilang ident="ZIP"}" class="form-control" name="awzip" value="">
								</div>
								<div class="col-xs-10">
									<input type="text" placeholder="{awmultilang ident="CITY"}" class="form-control" name="awcity" value="">
								</div>
								<div class="col-xs-12">&nbsp;</div>
							</div>
							<div class="form-group">
								<label for="mobile">{awmultilang ident="STREET"} {awmultilang ident="AND"} {awmultilang ident="BUILDINGNR"}</label>
								<input type="text" placeholder="Straße" id="mobile" class="form-control" name="awstreet" value="">
							</div>

                            <div class="form-group">
                                <label for="password">{awmultilang ident="PASSWORD"}</label>
                                <input type="text" placeholder="{awmultilang ident="PASSWORD"}" id="password" class="form-control" name="awpassword" value="">
                            </div>

							<div class="form-group">
								<label for="country">{awmultilang ident="COUNTRY"}</label>
								<select class="form-control" name="awcountry">
									<option value="1">{awmultilang ident="GERMANY"}</option>
									<option value="2">{awmultilang ident="AUSTRIA"}</option>
									<option value="3">{awmultilang ident="SWISS"}</option>
									<option value="4">{awmultilang ident="FRANCE"}</option>
									<option value="5">{awmultilang ident="SPAIN"}</option>
									<option value="6">{awmultilang ident="UNITEDKINGDOM"}</option>
									<option value="7">{awmultilang ident="NOTSETTED"}</option>
								</select>
							</div>
						</div><!-- /.box-body -->

						<div class="box-footer">
							<button class="btn btn-primary" type="submit">{awmultilang ident="ADD"}</button>
							<a class="btn btn-default" href="index.php?cl=user">{awmultilang ident="CANCEL"}</a>
						</div>
					</form>
				</div>
            </div>
			
			
		</div>
	</section><!-- /.content -->
</div><!-- /.content-wrapper -->
{include file="tpl/footer.tpl"}
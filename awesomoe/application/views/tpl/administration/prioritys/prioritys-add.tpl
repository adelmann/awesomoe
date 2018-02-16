{include file="tpl/header.tpl"}
{include file="tpl/sidebar.tpl"}
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
	<section class="content-header">
		<h1>
			{awmultilang ident="PRIORITYS"} - {awmultilang ident="EDIT"}
			<small>Optional description</small>
		</h1>
		{include file="tpl/breadcrumb.tpl"}
	</section>
	<!-- Main content -->
	<section class="content" id="workflowedit">
		<div class="row">
			<div class="col-md-12">
				<div class="box box-solid">
					<div class="box-header with-border">
						<i class="fa fa-th"></i>
						<h3 class="box-title">{awmultilang ident="PRIORITY"} {awmultilang ident="EDIT"}</h3>
					</div>
					<form role="form" action="index.php" method="POST">
						<input type="hidden" name="cl" value="prioritys">
						<input type="hidden" name="fnc" value="save">
						<input type="hidden" name="awid" value="-1">
						<div class="box-body">
                            <table class="table table-bordered" id="workflowsteps">
                                <tbody>
                                <tr>
                                  <th>{awmultilang ident="NAME"}</th>
                                  <th>{awmultilang ident="SORT"}</th>
                                  <th>{awmultilang ident="STYLE"}</th>
                                </tr>
                                    <tr class="datas">
                                        <td>
                                            <input type="text" placeholder="{awmultilang ident="NAME"}" id="name" class="form-control" name="awname" value="">
                                        </td>
                                      <td>
											<input type="text" placeholder="{awmultilang ident="SORT"}" id="name" class="form-control" name="awsort" value="">
                                      </td>
									  <td>
											<select class="form-control" name="awcolor">
												<option value="0" {if !empty($prioitem.awcolor) && $prioitem.awcolor == 0} selected="selected"{/if}>{awmultilang ident="GREY"}</option>
												<option value="1" {if !empty($prioitem.awcolor) && $prioitem.awcolor == 1} selected="selected"{/if}>{awmultilang ident="GREEN"}</option>
												<option value="2" {if !empty($prioitem.awcolor) && $prioitem.awcolor == 2} selected="selected"{/if}>{awmultilang ident="YELLOW"}</option>
												<option value="3" {if !empty($prioitem.awcolor) && $prioitem.awcolor == 3} selected="selected"{/if}>{awmultilang ident="RED"}</option>
												<option value="4" {if !empty($prioitem.awcolor) && $prioitem.awcolor == 4} selected="selected"{/if}>{awmultilang ident="BLUE"}</option>
											</select>
                                      </td>
                                    </tr>
                                </tbody>
                            </table>
						</div>
						<div class="box-footer">
							<button class="btn btn-primary" type="submit">{awmultilang ident="SAVE"}</button>
							<a class="btn btn-default" href="index.php?cl=prioritys">{awmultilang ident="CANCEL"}</a>
						</div>
					</form>
				</div>
            </div>
		</div>
	</section><!-- /.content -->
</div><!-- /.content-wrapper -->
{include file="tpl/footer.tpl"}
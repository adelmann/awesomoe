	{include file="tpl/modal/modal-delete.tpl"}
	<!-- Main Footer -->
      <footer class="main-footer">
        <!-- To the right -->
        <div class="pull-right hidden-xs">
            {$sFooterInfo} - V. 0.8
        </div>
        <!-- Default to the left --> 
        <strong>Copyright &copy; 2015 <a href="{$sCopyrightLink}">{$sCopyright}</a>.</strong>
      </footer>
    </div><!-- ./wrapper -->

	<!-- jQuery 2.1.3 -->
    <script src="{$tpldir}src/themefiles/plugins/jQuery/jQuery-2.1.3.min.js"></script>
    <!-- jQuery UI 1.11.2 -->
     <!--<script src="{$tpldir}src/jquery-ui.min.js" type="text/javascript"></script>-->
    <script src="http://code.jquery.com/ui/1.11.2/jquery-ui.min.js" type="text/javascript"></script>
    <!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
    <script>
      $.widget.bridge('uibutton', $.ui.button);
    </script>
    <!-- Bootstrap 3.3.2 JS -->
    <script src="{$tpldir}src/themefiles/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>    


    <script src="{$tpldir}src/themefiles/plugins/slimScroll/jquery.slimscroll.min.js" type="text/javascript"></script>
  
    <!-- AdminLTE App -->
    <script src="{$tpldir}src/themefiles/plugins/datepicker/bootstrap-datepicker.js" type="text/javascript"></script>
	<script src="{$tpldir}src/themefiles/plugins/timepicker/bootstrap-timepicker.min.js" type="text/javascript"></script>
    <script src="{$tpldir}src/themefiles/dist/js/app.min.js" type="text/javascript"></script>
	<script src="{$tpldir}src/themefiles/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.all.min.js" type="text/javascript"></script>
	<!-- InputMask -->
    <script src="{$tpldir}src/themefiles/plugins/select2/select2.full.min.js"></script>
    <!-- Calendar -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.10.2/moment.min.js"></script>
    <script src="{$tpldir}src/themefiles/plugins/fullcalendar/fullcalendar.min.js"></script>

    <!-- END -->
    <script src="{$tpldir}src/themefiles/plugins/input-mask/jquery.inputmask.js" type="text/javascript"></script>
    <script src="{$tpldir}src/themefiles/plugins/input-mask/jquery.inputmask.date.extensions.js" type="text/javascript"></script>
    <script src="{$tpldir}src/themefiles/plugins/input-mask/jquery.inputmask.extensions.js" type="text/javascript"></script>
    <!-- date-range-picker -->

	{*
	{if array_key_exists('task', $aBreadCrumb)}
		<!-- Uploader -->
		<script src='{$tpldir}src/uploader/jquery.form.js' type="text/javascript" language="javascript"></script>
		<script src='{$tpldir}src/uploader/jquery.metaData.js' type="text/javascript" language="javascript"></script>
	{/if}
    *}
	<script src="{$tpldir}src/aw_main.js" type="text/javascript"></script>

    {if !empty($calendatentrys)}
        <script type="text/javascript">
            $(document).ready(function() {
                $('#calendar').fullCalendar({
                    header: {
                        left: 'prev,next today',
                        center: 'title',
                        right: 'month,agendaWeek,agendaDay'
                    },
                    buttonText: {
                        today: '{awmultilang ident="TODAY"}',
                        month: '{awmultilang ident="MONTH"}',
                        week: '{awmultilang ident="WEEK"}',
                        day: '{awmultilang ident="DAY"}'
                    },
                    editable: false,
                    events: [
                        {$calendatentrys}
                    ]
                });
            });
        </script>
    {/if}

  </body>
</html>
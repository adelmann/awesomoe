<?php $this->translateContent('STEP1TEXT');?>
<hr>

<form action="index.php?step=2">
    <div class="row">
        <div class="col-sm-6">
            <div class="form-group">
                <label for="language"><?php $this->translateContent('STEP1INLANG');?></label>
            </div>
        </div>
        <div class="col-sm-6">
            <div class="form-group">
                <select name="language" class="form-control">
                    <option value="de"><?php $this->translateContent('LANGDE');?></option>
                    <option value="en"><?php $this->translateContent('LANGEN');?></option>
                </select>
            </div>
        </div>
    </div>
    <hr>
    <input type="hidden" name="step" value="2" />
    <input type="submit" value="<?php $this->translateContent('NEXT');?>" />
</form>
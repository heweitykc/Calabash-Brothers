package com.view.tipcell
{
    import com.model.vo.*;
    import flash.text.*;

    public class PersonTips extends BaseTips
    {
        private var tips:TextField;
        private var _info:RoleInfo;

        public function PersonTips()
        {
            this.tips = new TextField();
            this.tips.autoSize = TextFieldAutoSize.LEFT;
            this.tips.textColor = 16777215;
            this.tips.x = 0;
            return;
        }// end function

        override public function repaint(param1:Object) : void
        {
            this._info = param1 as RoleInfo;
            return;
        }// end function

    }
}

package com.game.newactivity.popularPay.control
{
    import com.*;
    import com.game.newactivity.model.*;
    import com.game.newactivity.popularPay.view.*;
    import com.staticdata.*;

    public class PopularPayControl extends Object
    {
        private var _panel:PopularPayBox;
        private static var _instance:PopularPayControl;

        public function PopularPayControl()
        {
            return;
        }// end function

        public function openPanel() : void
        {
            if (NewActivityModel.getInstance().getActivityByGroup(NewActivityConfig.GROUP_POPULAR_PAY) == null)
            {
                Global.popManager.addedToMouseCue("还没有活动数据XXXXXXOOOOOO");
            }
            if (!this._panel)
            {
                this._panel = new PopularPayBox();
                Global.popManager.addPop(this._panel);
            }
            this._panel.openOrClose();
            return;
        }// end function

        public static function getInstance() : PopularPayControl
        {
            if (!_instance)
            {
                _instance = new PopularPayControl;
            }
            return _instance;
        }// end function

    }
}

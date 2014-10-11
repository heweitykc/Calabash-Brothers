package com.game.newactivity.mergeService.control
{
    import com.*;
    import com.game.newactivity.mergeService.view.*;

    public class MergeServiceControl extends Object
    {
        private var _panel:MergeServicePanel;
        private static var _instance:MergeServiceControl;

        public function MergeServiceControl()
        {
            return;
        }// end function

        public function openOrClose(param1:String, param2:int) : void
        {
            if (this._panel == null)
            {
                this._panel = new MergeServicePanel();
                Global.popManager.addPop(this._panel);
            }
            this._panel.index = param2;
            this._panel.actType = param1;
            this._panel.openOrClose();
            return;
        }// end function

        public static function get instance() : MergeServiceControl
        {
            if (_instance == null)
            {
                _instance = new MergeServiceControl;
            }
            return _instance;
        }// end function

    }
}

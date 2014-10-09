package com.game.xscb.view
{
    import com.f1.ui.*;
    import com.game.xscb.model.*;
    import flash.text.*;

    public class ScarletHoldTaskComponent extends Component
    {
        private var _describeTxt:TextField;
        private var _targetTxt:TextField;
        private var _phase:PhaseVo;
        private var _count:int;

        public function ScarletHoldTaskComponent(param1 = null, param2:String = null)
        {
            super.initComponentUI(param1, param2);
            this.initUI();
            return;
        }// end function

        public function get phase() : PhaseVo
        {
            return this._phase;
        }// end function

        private function initUI() : void
        {
            this._describeTxt = getDisplayChildByName("txt_task_describe");
            this._targetTxt = getDisplayChildByName("txt_target");
            return;
        }// end function

        public function set phase(param1:PhaseVo) : void
        {
            this._phase = param1;
            if (param1 == null)
            {
                this.describe = "";
                this._targetTxt.text = "";
            }
            else
            {
                this.describe = this._phase.describe;
                this.setValue(this._phase.completed, this._phase.target);
            }
            return;
        }// end function

        public function clear() : void
        {
            this.describe = "";
            this._targetTxt.text = "";
            return;
        }// end function

        public function set describe(param1:String) : void
        {
            this._describeTxt.htmlText = param1;
            return;
        }// end function

        public function setValue(param1:int, param2:int = 0) : void
        {
            if (this._phase == null)
            {
                return;
            }
            if (param2 == 0)
            {
                param2 = this._phase.target;
            }
            if (param1 < param2)
            {
                this._targetTxt.textColor = 16711680;
            }
            else
            {
                this._targetTxt.textColor = 65280;
            }
            this._targetTxt.text = param1 + "/" + param2;
            return;
        }// end function

    }
}

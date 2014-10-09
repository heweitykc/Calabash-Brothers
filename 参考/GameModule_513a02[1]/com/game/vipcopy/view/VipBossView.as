package com.game.vipcopy.view
{
    import com.*;
    import com.f1.*;
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import com.game.country.events.*;
    import com.game.vipcopy.control.*;
    import com.game.vipcopy.model.*;
    import com.model.*;
    import flash.events.*;

    public class VipBossView extends Component
    {
        private var btn1:BaseButton;
        private var btn2:BaseButton;
        private var btn3:BaseButton;
        private var btn4:BaseButton;
        private var btn5:BaseButton;
        private var btn6:BaseButton;
        private var copyIdArray:Array;
        private var vipArray:Array;

        public function VipBossView()
        {
            this.copyIdArray = [3007, 3008, 3009];
            this.vipArray = [4, 5, 7];
            initComponentUI("VipBossSelectPanel");
            this.initUI();
            this.addEvents();
            return;
        }// end function

        private function initUI() : void
        {
            this.btn1 = new BaseButton(getDisplayChildByName("btn1"));
            this.btn2 = new BaseButton(getDisplayChildByName("btn2"));
            this.btn3 = new BaseButton(getDisplayChildByName("btn3"));
            this.btn4 = new BaseButton(getDisplayChildByName("btn4"));
            this.btn5 = new BaseButton(getDisplayChildByName("btn5"));
            this.btn6 = new BaseButton(getDisplayChildByName("btn6"));
            return;
        }// end function

        private function addEvents() : void
        {
            this.btn1.addEventListener(MouseEvent.MOUSE_OVER, this.__over, false, 0, true);
            this.btn1.addEventListener(MouseEvent.MOUSE_OUT, this.__out, false, 0, true);
            this.btn2.addEventListener(MouseEvent.MOUSE_OVER, this.__over, false, 0, true);
            this.btn2.addEventListener(MouseEvent.MOUSE_OUT, this.__out, false, 0, true);
            this.btn3.addEventListener(MouseEvent.MOUSE_OVER, this.__over, false, 0, true);
            this.btn3.addEventListener(MouseEvent.MOUSE_OUT, this.__out, false, 0, true);
            this.btn1.addEventListener(MouseEvent.CLICK, this.__click, false, 0, true);
            this.btn2.addEventListener(MouseEvent.CLICK, this.__click, false, 0, true);
            this.btn3.addEventListener(MouseEvent.CLICK, this.__click, false, 0, true);
            this.btn4.addEventListener(MouseEvent.CLICK, this.__click, false, 0, true);
            this.btn5.addEventListener(MouseEvent.CLICK, this.__click, false, 0, true);
            this.btn6.addEventListener(MouseEvent.CLICK, this.__click, false, 0, true);
            return;
        }// end function

        private function __over(event:MouseEvent = null) : void
        {
            event.target.filters = [FrameworkGlobal.YELLOW_TXT_FILTER];
            return;
        }// end function

        private function __out(event:MouseEvent = null) : void
        {
            event.target.filters = null;
            return;
        }// end function

        private function __click(event:MouseEvent = null) : void
        {
            var _loc_2:* = false;
            var _loc_3:* = 0;
            switch(event.target)
            {
                case this.btn1:
                case this.btn4:
                {
                    _loc_2 = UserObj.getInstance().playerInfo.vipid >= this.vipArray[0];
                    _loc_3 = VipCopyData.getInstance().getCopyLeftNum(this.copyIdArray[0]);
                    if (!_loc_2 || _loc_3 > 0)
                    {
                        VipCopyData.getInstance().curSelect = 1;
                        VipCopyControl.getInstance().openVipCopyEnterBox();
                    }
                    else
                    {
                        Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("11411"));
                    }
                    break;
                }
                case this.btn2:
                case this.btn5:
                {
                    _loc_2 = UserObj.getInstance().playerInfo.vipid >= this.vipArray[1];
                    _loc_3 = VipCopyData.getInstance().getCopyLeftNum(this.copyIdArray[1]);
                    if (!_loc_2 || _loc_3 > 0)
                    {
                        VipCopyData.getInstance().curSelect = 2;
                        VipCopyControl.getInstance().openVipCopyEnterBox();
                    }
                    else
                    {
                        Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("11411"));
                    }
                    break;
                }
                case this.btn3:
                case this.btn6:
                {
                    _loc_2 = UserObj.getInstance().playerInfo.vipid >= this.vipArray[2];
                    _loc_3 = VipCopyData.getInstance().getCopyLeftNum(this.copyIdArray[2]);
                    if (!_loc_2 || _loc_3 > 0)
                    {
                        VipCopyData.getInstance().curSelect = 3;
                        VipCopyControl.getInstance().openVipCopyEnterBox();
                    }
                    else
                    {
                        Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("11411"));
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function clear() : void
        {
            return;
        }// end function

        public function update(event:CountryEvent = null) : void
        {
            var _loc_3:* = false;
            var _loc_4:* = 0;
            if (!this.parent)
            {
                return;
            }
            var _loc_2:* = 0;
            while (_loc_2 < this.copyIdArray.length)
            {
                
                _loc_3 = UserObj.getInstance().playerInfo.vipid >= this.vipArray[_loc_2];
                _loc_4 = VipCopyData.getInstance().getCopyLeftNum(this.copyIdArray[_loc_2]);
                if (!_loc_3 || _loc_4 > 0)
                {
                    this["btn" + (_loc_2 + 4)].enabled = true;
                    this["btn" + (_loc_2 + 4)].filters = null;
                    this["btn" + (_loc_2 + 1)].getDisplay()["mc_pass"].gotoAndStop(2);
                }
                else
                {
                    this["btn" + (_loc_2 + 4)].enabled = false;
                    this["btn" + (_loc_2 + 4)].filters = [FrameworkGlobal.colorMat];
                    this["btn" + (_loc_2 + 1)].getDisplay()["mc_pass"].gotoAndStop(1);
                }
                _loc_2++;
            }
            return;
        }// end function

        public function reqData() : void
        {
            return;
        }// end function

        override public function finalize() : void
        {
            super.finalize();
            return;
        }// end function

    }
}

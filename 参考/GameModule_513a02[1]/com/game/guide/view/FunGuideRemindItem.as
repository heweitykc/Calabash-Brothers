package com.game.guide.view
{
    import com.f1.*;
    import com.f1.interfaces.ui.list.*;
    import com.f1.ui.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.game.guide.consts.*;
    import com.game.guide.control.*;
    import com.view.icon.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class FunGuideRemindItem extends Component implements IItem
    {
        private var _info:Object;
        private var _icon:IconBase;
        private var _starArr:Array;
        private var _txtTitle:TextField;
        private var _btn:BaseButton;

        public function FunGuideRemindItem(param1)
        {
            super.initComponentUI(param1);
            this.initUI();
            this._btn.addEvtListener(MouseEvent.CLICK, this.__click);
            return;
        }// end function

        private function initUI() : void
        {
            var _loc_2:* = null;
            this._icon = new IconBase("shopboxbg");
            this._icon.image.x = 6;
            this._icon.image.y = 6;
            this._icon.x = 13;
            this._icon.y = 8;
            addChild(this._icon);
            this._starArr = [];
            var _loc_1:* = 1;
            while (_loc_1 <= 5)
            {
                
                _loc_2 = getDisplayChildByName("star_" + _loc_1);
                this._starArr.push(_loc_2);
                _loc_1++;
            }
            this._txtTitle = getDisplayChildByName("txt_title");
            this._btn = new BaseButton(getDisplayChildByName("ok_btn"));
            this._btn.setText(LanguageCfgObj.getInstance().getByIndex("10729"));
            return;
        }// end function

        public function get key()
        {
            return null;
        }// end function

        public function get obj()
        {
            return null;
        }// end function

        public function set info(param1) : void
        {
            this._info = param1;
            var _loc_2:* = this._info.priority / 100 + 1;
            var _loc_3:* = new Object();
            _loc_3.url = FunGuideConst.getIconByType(param1.type);
            this._icon.setInfo(_loc_3);
            switch(this._info.type)
            {
                case FunGuideConst.PRAY:
                {
                    this._txtTitle.text = LanguageCfgObj.getInstance().getByIndex("10730");
                    break;
                }
                case FunGuideConst.SCARLETHOLD:
                {
                    this._txtTitle.text = LanguageCfgObj.getInstance().getByIndex("10731");
                    break;
                }
                case FunGuideConst.BELIAWORLD:
                {
                    this._txtTitle.text = LanguageCfgObj.getInstance().getByIndex("10732");
                    break;
                }
                case FunGuideConst.BOSSGUIDE:
                {
                    this._txtTitle.text = LanguageCfgObj.getInstance().getByIndex("10733");
                    break;
                }
                case FunGuideConst.STALLS:
                {
                    this._txtTitle.text = LanguageCfgObj.getInstance().getByIndex("10734");
                    break;
                }
                case FunGuideConst.MALL:
                {
                    this._txtTitle.text = LanguageCfgObj.getInstance().getByIndex("10735");
                    break;
                }
                default:
                {
                    break;
                }
            }
            var _loc_4:* = 0;
            while (_loc_4 < _loc_2)
            {
                
                this._starArr[_loc_4].gotoAndStop(1);
                _loc_4++;
            }
            while (_loc_4 < 5)
            {
                
                this._starArr[_loc_4].gotoAndStop(2);
                _loc_4++;
            }
            return;
        }// end function

        public function set obj(param1) : void
        {
            this.info = param1;
            return;
        }// end function

        public function get label() : String
        {
            return null;
        }// end function

        private function __click(event:MouseEvent) : void
        {
            FunGuideControl.getInstance().openFunGuide(this._info.type);
            if (parent is BaseBox)
            {
                (parent as BaseBox).close();
            }
            return;
        }// end function

        public function setSelected(param1:Boolean, param2:Boolean = true) : void
        {
            return;
        }// end function

        public function get selected() : Boolean
        {
            return false;
        }// end function

    }
}

package com.game.vip.view
{
    import com.cfg.obj.*;
    import com.f1.*;
    import com.f1.interfaces.ui.list.*;
    import com.f1.ui.*;
    import com.f1.ui.image.*;
    import com.f1.ui.tips.*;
    import com.f1.utils.*;
    import com.game.vip.consts.*;
    import com.staticdata.*;
    import flash.display.*;
    import flash.text.*;

    public class VIPFunItem extends Component implements IItem
    {
        private var _back:Sprite;
        private var _titleBg:Bitmap;
        private var _type:String;
        private var _attribute:String;
        private var _arr:Array;

        public function VIPFunItem(param1 = null, param2:String = null)
        {
            super(param1, param2);
            this._back = ToolKit.getNew("vipfunitem");
            addChild(this._back);
            this._arr = [];
            return;
        }// end function

        public function get key()
        {
            return;
        }// end function

        public function get obj()
        {
            return;
        }// end function

        public function set info(param1) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            this._type = param1;
            this._attribute = this._type.replace("vip", "q");
            this._titleBg = ToolKit.getNewDO(this._type) as Bitmap;
            this._titleBg.x = (110 - this._titleBg.width) * 0.5;
            this._titleBg.y = (this._back.height - this._titleBg.height) * 0.5;
            addChild(this._titleBg);
            var _loc_2:* = 0;
            while (_loc_2 < 9)
            {
                
                if (this._type != VipConst.VIP_ATTRIBUTE)
                {
                    _loc_3 = this._attribute;
                    if (_loc_3 == "q_scarlet")
                    {
                        _loc_3 = "q_devil";
                    }
                    _loc_4 = VIPShowCfgObj.getInstance().getAttribute((_loc_2 + 1), _loc_3);
                    if (_loc_4 == "0")
                    {
                        _loc_5 = ToolKit.getNew("vip_wrong");
                        _loc_5.x = 112 + _loc_2 * 56 + (56 - _loc_5.width) * 0.5;
                        _loc_5.y = (this._back.height - _loc_5.height) * 0.5;
                        addChild(_loc_5);
                    }
                    else if (_loc_4 == "1")
                    {
                        _loc_5 = ToolKit.getNew("vip_right");
                        _loc_5.x = 112 + _loc_2 * 56 + (56 - _loc_5.width) * 0.5;
                        _loc_5.y = (this._back.height - _loc_5.height) * 0.5;
                        addChild(_loc_5);
                    }
                    else
                    {
                        _loc_6 = new TextField();
                        _loc_6.selectable = false;
                        _loc_6.autoSize = "left";
                        _loc_6.filters = [FrameworkGlobal.BLACK_FILTER];
                        _loc_6.textColor = 2031360;
                        _loc_7 = _loc_6.defaultTextFormat;
                        _loc_7.font = "SimSun";
                        _loc_7.size = 12;
                        _loc_6.defaultTextFormat = _loc_7;
                        _loc_6.text = _loc_4;
                        addChild(_loc_6);
                        _loc_6.x = 112 + _loc_2 * 56 + (56 - _loc_6.width) * 0.5;
                        _loc_6.y = (this._back.height - _loc_6.height) * 0.5;
                    }
                }
                else
                {
                    _loc_4 = VIPShowCfgObj.getInstance().getAttribute((_loc_2 + 1), this._attribute);
                    if (_loc_4 == "0")
                    {
                        _loc_5 = ToolKit.getNew("vip_wrong");
                        _loc_5.x = 112 + _loc_2 * 56 + (56 - _loc_5.width) * 0.5;
                        _loc_5.y = (this._back.height - _loc_5.height) * 0.5;
                        addChild(_loc_5);
                    }
                    else
                    {
                        _loc_8 = new Sprite();
                        _loc_9 = new Image();
                        _loc_9.load(Params.BUFF_ICON_PATH + "i40011.png");
                        _loc_8.x = 112 + _loc_2 * 56 + 16;
                        _loc_8.y = (this._back.height - 24) * 0.5;
                        _loc_8.addChild(_loc_9);
                        addChild(_loc_8);
                        StringTip.create(_loc_8, _loc_4);
                    }
                }
                _loc_2++;
            }
            return;
        }// end function

        public function set obj(param1) : void
        {
            if (!param1)
            {
                return;
            }
            this.info = param1;
            return;
        }// end function

        public function get label() : String
        {
            return "";
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

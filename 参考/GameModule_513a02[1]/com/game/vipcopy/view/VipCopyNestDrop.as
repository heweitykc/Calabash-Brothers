package com.game.vipcopy.view
{
    import com.cfg.obj.*;
    import com.cfg.vo.*;
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import com.game.role.util.*;
    import com.game.vipcopy.model.*;
    import com.model.*;
    import com.model.vo.*;
    import com.util.*;
    import com.view.icon.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class VipCopyNestDrop extends Component
    {
        private var _panel:Component;
        private var _btnClose:BaseButton;
        private var copyIdArray:Array;
        private var mc1:MovieClip;
        private var mc2:MovieClip;
        private var mc3:MovieClip;
        private var mc4:MovieClip;
        private var mc5:MovieClip;
        private var mc6:MovieClip;
        private var mc7:MovieClip;
        private var mc8:MovieClip;
        private var mc9:MovieClip;
        private var _txtRoleLev:TextField;
        private var _txtZoneLev:TextField;

        public function VipCopyNestDrop(param1:Component)
        {
            this.copyIdArray = [3007, 3008, 3009];
            super("vipNestDrop");
            this._panel = param1;
            this.initpanel();
            this.addEvents();
            return;
        }// end function

        private function initpanel() : void
        {
            this._btnClose = new BaseButton(getDisplayChildByName("btnClose"));
            this._txtRoleLev = TextField(getDisplayChildByName("txtRoleLev"));
            this._txtZoneLev = TextField(getDisplayChildByName("txtZoneLev"));
            var _loc_1:* = 0;
            while (_loc_1 < 9)
            {
                
                this["mc" + (_loc_1 + 1)] = getDisplayChildByName("mc" + (_loc_1 + 1));
                _loc_1++;
            }
            return;
        }// end function

        private function addEvents() : void
        {
            this.addEventListener(MouseEvent.CLICK, this.onMouseClick);
            return;
        }// end function

        protected function onMouseClick(event:MouseEvent) : void
        {
            switch(event.target)
            {
                case this._btnClose:
                {
                    this.close();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function update() : void
        {
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = null;
            if (!UILoaded)
            {
                this.close();
                return;
            }
            var _loc_1:* = VipCopyData.getInstance().curSelect;
            var _loc_2:* = ZonesCloneCfg.getInstance().getZonesInfoFromId(this.copyIdArray[(_loc_1 - 1)]);
            var _loc_3:* = [];
            var _loc_4:* = String(_loc_2.reward).split("|");
            var _loc_5:* = UserObj.getInstance().playerInfo.level;
            var _loc_6:* = "";
            var _loc_9:* = 0;
            while (_loc_9 < _loc_4.length)
            {
                
                _loc_11 = String(_loc_4[_loc_9]).split("_");
                if (_loc_5 < _loc_11[0])
                {
                    _loc_8 = _loc_11[0];
                    _loc_6 = _loc_11[2];
                    _loc_7 = _loc_9 + 1;
                    break;
                }
                _loc_9++;
            }
            this._txtRoleLev.text = RoleLevelUtil.getMasterLevel(_loc_8);
            this._txtZoneLev.text = _loc_7.toString();
            _loc_3 = _loc_3.concat(_loc_6.split(";"));
            var _loc_10:* = 0;
            while (_loc_10 < 8)
            {
                
                _loc_12 = PropUtil.createItemByCfg(_loc_3[_loc_10]);
                _loc_13 = new IconItem("");
                _loc_13.setWH(40, 40);
                _loc_13.setImageSize(40, 40);
                _loc_13.setInfo(_loc_12);
                _loc_13.x = 5;
                _loc_13.y = 5;
                if (this["mc" + (_loc_10 + 1)].numChildren)
                {
                    this["mc" + (_loc_10 + 1)].removeChildAt(0);
                }
                this["mc" + (_loc_10 + 1)].addChild(_loc_13);
                _loc_10++;
            }
            return;
        }// end function

        public function close() : void
        {
            if (this.parent)
            {
                this.parent.removeChild(this);
            }
            return;
        }// end function

        public function open() : void
        {
            if (!this.parent)
            {
                this.move(710 + 36, this._panel.height / 2);
                this._panel.addChild(this);
            }
            this.update();
            return;
        }// end function

        public function openOrClose() : void
        {
            if (this.parent)
            {
                this.close();
            }
            else
            {
                this.open();
            }
            return;
        }// end function

    }
}

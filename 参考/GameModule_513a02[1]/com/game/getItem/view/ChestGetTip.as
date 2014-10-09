package com.game.getItem.view
{
    import com.f1.*;
    import com.f1.ui.*;
    import com.f1.utils.*;
    import com.game.map.view.scrollcue.*;
    import com.game.prompt.utils.*;
    import com.greensock.*;
    import com.model.vo.*;
    import com.util.*;
    import com.view.icon.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.*;

    public class ChestGetTip extends Component
    {
        private var _icon:IconItem;
        private var _txt:TextField;
        private var _info:PropInfo;
        private var _scrollCue:ScrollCue;

        public function ChestGetTip(param1 = null, param2:String = null)
        {
            super(param1, param2);
            loadDisplay("res/chestget.swf");
            return;
        }// end function

        public function get scrollCue() : ScrollCue
        {
            return this._scrollCue;
        }// end function

        public function set scrollCue(param1:ScrollCue) : void
        {
            this._scrollCue = param1;
            return;
        }// end function

        public function get info() : PropInfo
        {
            return this._info;
        }// end function

        public function set info(param1:PropInfo) : void
        {
            this._info = param1;
            if (UILoaded)
            {
                this.update();
            }
            return;
        }// end function

        override protected function displayReady() : void
        {
            super.initComponentUI("chestgettips");
            this.initUI();
            this.addlistener();
            return;
        }// end function

        private function addlistener() : void
        {
            addEvtListener(Event.REMOVED_FROM_STAGE, this.__remove);
            return;
        }// end function

        private function __remove(event:Event) : void
        {
            var _loc_2:* = localToGlobal(new Point(this._icon.x, this._icon.y));
            ItemGetAnim.doFlyToBackPack(this._info.itemModelId, _loc_2);
            return;
        }// end function

        private function initUI() : void
        {
            this._icon = new IconItem();
            this._icon.image.x = 5;
            this._icon.image.y = 5;
            this._icon.setImageSize(56, 56);
            this._icon.setCountTxtXY(66 - 10, 66 - 20);
            this._icon.move(151, 10);
            addChild(this._icon);
            this._txt = getDisplayChildByName("txt");
            if (this._info)
            {
                this.update();
            }
            return;
        }// end function

        private function update() : void
        {
            this._icon.setInfo(this._info);
            var _loc_1:* = PropUtil.getEquipNameAndColor(this._info);
            this._txt.htmlText = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12048"), ["<font color = \'#" + _loc_1[1].toString(16) + "\'>" + _loc_1[0] + "</font>"]);
            scaleX = 0;
            scaleY = 0;
            TweenLite.to(this, 0.2, {x:x - _w * 0.5, y:y - _h * 0.5, scaleX:1, scaleY:1, onComplete:this.complete});
            if (this._scrollCue)
            {
                this._scrollCue.addChild(this);
            }
            return;
        }// end function

        private function complete() : void
        {
            TweenLite.delayedCall(1.5, this.disappear);
            return;
        }// end function

        private function disappear() : void
        {
            TweenLite.to(this, 0.2, {y:y - 160, alpha:0, onComplete:this.disappearCom});
            return;
        }// end function

        private function disappearCom() : void
        {
            if (parent)
            {
                parent.removeChild(this);
            }
            if (this._scrollCue)
            {
                this._scrollCue.next();
            }
            return;
        }// end function

    }
}

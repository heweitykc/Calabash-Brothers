package com.game.map.view
{
    import com.cfg.obj.*;
    import com.cfg.vo.*;
    import com.f1.*;
    import com.f1.manager.timer.*;
    import com.f1.utils.*;
    import flash.display.*;
    import flash.text.*;

    public class BossReliveItem extends BaseSprite
    {
        private var img:Bitmap;
        private var nameText:TextField;
        private var countText:TextField;
        private var _info:QMonsterBossQcfg;
        private var _count:int;

        public function BossReliveItem()
        {
            this.img = new Bitmap(ToolKit.getNew("bossReliveMark"));
            addChild(this.img);
            this.nameText = new TextField();
            this.nameText.autoSize = TextFieldAutoSize.LEFT;
            this.nameText.mouseWheelEnabled = false;
            this.nameText.wordWrap = false;
            this.nameText.filters = [FrameworkGlobal.BLACK_FILTER];
            addChild(this.nameText);
            this.countText = new TextField();
            this.countText.autoSize = TextFieldAutoSize.LEFT;
            this.countText.mouseWheelEnabled = false;
            this.countText.wordWrap = false;
            this.countText.filters = [FrameworkGlobal.BLACK_FILTER];
            addChild(this.countText);
            var _loc_1:* = false;
            mouseChildren = false;
            mouseEnabled = _loc_1;
            return;
        }// end function

        public function set info(param1:QMonsterBossQcfg) : void
        {
            this._info = param1;
            this.updateName();
            this.layout();
            return;
        }// end function

        public function set count(param1:int) : void
        {
            this._count = param1;
            this.updateCount();
            Ticker.killTimer(this.updateCount);
            Ticker.registerTimer(1, this.updateCount);
            this.layout();
            return;
        }// end function

        private function updateName() : void
        {
            var _loc_1:* = null;
            if (this._info)
            {
                _loc_1 = MonsterCfgObj.getInstance().getMonsterObjCfg(this._info.q_monsterid);
                this.nameText.htmlText = "<font color=\'#a5a5a5\'>" + _loc_1.q_name + "</font>";
            }
            return;
        }// end function

        private function updateCount() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            if (this._info)
            {
                _loc_1 = ToolKit.getServerTime() / 1000;
                _loc_2 = Math.ceil((this._count - _loc_1) / 60);
                if (_loc_2 <= 0)
                {
                    _loc_2 = 1;
                }
                this.countText.htmlText = "<font color=\'#fffc00\' size=\'14\'>" + StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12098"), [_loc_2]) + "</font>";
            }
            return;
        }// end function

        private function layout() : void
        {
            this.nameText.x = this.img.width - this.nameText.width >> 1;
            this.countText.x = this.img.width - this.countText.width >> 1;
            this.countText.y = this.nameText.y + this.nameText.height;
            this.img.y = this.countText.y + this.countText.height;
            setWH(width, height);
            return;
        }// end function

        override public function finalize() : void
        {
            Ticker.killTimer(this.updateCount);
            super.finalize();
            return;
        }// end function

    }
}

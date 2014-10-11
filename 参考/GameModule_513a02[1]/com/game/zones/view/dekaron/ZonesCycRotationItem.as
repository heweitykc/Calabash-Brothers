package com.game.zones.view.dekaron
{
    import com.cfg.obj.*;
    import com.cfg.vo.*;
    import com.f1.*;
    import com.f1.ui.tips.*;
    import com.f1.utils.*;
    import com.f1.vmc.*;
    import com.game.team.view.*;
    import com.staticdata.*;
    import com.view.tipcell.*;
    import flash.display.*;
    import flash.events.*;

    public class ZonesCycRotationItem extends ListItemBase
    {
        private var _levelStage:int;
        private var _level:int;
        private var _mScale:Number;
        private var _mLocalX:Number;
        private var _mLocalY:Number;
        private var photo:VMCView;
        private var photoCont:BaseSprite;
        private var _back:Sprite;
        private var _info:ZonesTableVo;
        private var _ufoBack:MovieClip;

        public function ZonesCycRotationItem(param1:String = "")
        {
            super(param1);
            return;
        }// end function

        override protected function getComp() : void
        {
            super.getComp();
            this.mouseChildren = false;
            this._ufoBack = _content.getChildByName("ufo_back") as MovieClip;
            this.photoCont = new BaseSprite();
            this.photo = new VMCView();
            this.photoCont.addChild(this.photo);
            this.photoCont.move(5, -19);
            _content.addChild(this.photoCont);
            StringTip.create(this, "");
            return;
        }// end function

        override protected function mouseOverHandler(event:MouseEvent) : void
        {
            super.mouseOutHandler(event);
            if (this._level != 0 && _index == 1)
            {
                this.setMonsterPhoto(5);
            }
            return;
        }// end function

        override protected function mouseOutHandler(event:MouseEvent) : void
        {
            super.mouseOutHandler(event);
            if (this._level != 0 && _index == 1)
            {
                this.setMonsterPhoto(1);
            }
            return;
        }// end function

        private function callBackFun() : void
        {
            this.photo.scale = 1;
            var _loc_1:* = this.photo.width > 250 ? (250 / this.photo.width) : (1);
            var _loc_2:* = this.photo.height > 250 ? (250 / this.photo.height) : (1);
            var _loc_3:* = _loc_1 < _loc_2 ? (_loc_1) : (_loc_2);
            if (_index > 1)
            {
                this.photo.scale = _loc_3 * 1.5;
            }
            else
            {
                this.photo.scale = 1;
            }
            return;
        }// end function

        public function setIsPass(param1:Boolean) : void
        {
            if (this._level != 0)
            {
                this.visible = !param1;
            }
            else
            {
                this.visible = true;
            }
            return;
        }// end function

        override protected function freshItem() : void
        {
            var _loc_1:* = 0;
            if (this._level == 0)
            {
                this._info = null;
                this._ufoBack.gotoAndStop(2);
                this.photo.finalize();
                if (_index == 1)
                {
                }
            }
            else
            {
                this._ufoBack.gotoAndStop(1);
                _loc_1 = 8000 + this.levelStage * 10 + this._level;
                this._info = ZonesCloneCfg.getInstance().getZonesInfoFromId(_loc_1);
                if (this._info)
                {
                    this.setMonsterPhoto(1);
                }
            }
            if (this._level != 0 && _index == 1)
            {
                this.creatTips(true);
                this.filters = [];
            }
            else
            {
                this.creatTips(false);
                if (this._level == 0 && _index == 1)
                {
                    this.filters = [];
                }
                else
                {
                    this.filters = [ColorFilter.getGrayFilter()];
                }
            }
            return;
        }// end function

        private function creatTips(param1:Boolean) : void
        {
            if (param1 && this._info)
            {
                ItemTips.create(this, this._info, ZonesDekaronUFOTips);
            }
            else
            {
                ItemTips.dispose(this);
            }
            return;
        }// end function

        private function setMonsterPhoto(param1:int) : void
        {
            var _loc_2:* = null;
            if (!this._info)
            {
                return;
            }
            switch(param1)
            {
                case 5:
                {
                    _loc_2 = "05";
                    break;
                }
                case 1:
                {
                    _loc_2 = "01";
                    break;
                }
                default:
                {
                    _loc_2 = "01";
                    break;
                    break;
                }
            }
            var _loc_3:* = MonsterCfgObj.getInstance().getMonsterCfg(this._info.monster);
            if (_loc_3)
            {
                this.photo.loadRes(Params.ROLE_RES_PATH + _loc_3.q_sculpt_resid + "/act" + _loc_2 + "/135.png", null, true, this.callBackFun);
                this.photo.updatePose("135", true);
                this.photo.auto = true;
            }
            return;
        }// end function

        public function get mLocalX() : Number
        {
            return this._mLocalX;
        }// end function

        public function set mLocalX(param1:Number) : void
        {
            this._mLocalX = param1;
            this.x = this._mLocalX;
            return;
        }// end function

        public function get mLocalY() : Number
        {
            return this._mLocalY;
        }// end function

        public function set mLocalY(param1:Number) : void
        {
            this._mLocalY = param1;
            this.y = this._mLocalY;
            return;
        }// end function

        override public function set index(param1:int) : void
        {
            super.index = param1;
            _index = param1;
            return;
        }// end function

        override public function get info()
        {
            return this._info;
        }// end function

        override public function set info(param1) : void
        {
            this._info = param1;
            this.freshItem();
            return;
        }// end function

        public function get mScale() : Number
        {
            return this._mScale;
        }// end function

        public function set mScale(param1:Number) : void
        {
            this._mScale = param1;
            var _loc_2:* = this._mScale;
            this.scaleY = this._mScale;
            this.scaleX = _loc_2;
            return;
        }// end function

        public function get back() : Sprite
        {
            return this._back;
        }// end function

        public function set back(param1:Sprite) : void
        {
            this._back = param1;
            if (param1)
            {
                this.addChild(this.back);
                this.setChildIndex(this.back, 0);
            }
            return;
        }// end function

        public function get levelStage() : int
        {
            return this._levelStage;
        }// end function

        public function set levelStage(param1:int) : void
        {
            this._levelStage = param1;
            return;
        }// end function

        public function get level() : int
        {
            return this._level;
        }// end function

        public function set level(param1:int) : void
        {
            this._level = param1;
            this.freshItem();
            return;
        }// end function

    }
}

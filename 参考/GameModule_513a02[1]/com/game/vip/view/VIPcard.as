package com.game.vip.view
{
    import com.cfg.obj.*;
    import com.f1.ui.*;
    import com.f1.ui.image.*;
    import com.f1.ui.tips.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class VIPcard extends Component
    {
        private var _txt:TextField;
        private var _image:Image;
        private var _bg:MovieClip;
        private var _selected:Boolean;
        private var _type:int;
        private var _info:ShopItemInfo;
        private var _mask:Sprite;

        public function VIPcard(param1 = null, param2:int = 0)
        {
            super(param1);
            this.initUI();
            this.type = param2;
            addEvtListener(MouseEvent.ROLL_OVER, this.__over);
            addEvtListener(MouseEvent.ROLL_OUT, this.__out);
            return;
        }// end function

        public function get type() : int
        {
            return this._type;
        }// end function

        public function set type(param1:int) : void
        {
            var _loc_2:* = null;
            this._type = param1;
            switch(this._type)
            {
                case 3:
                {
                    this._image.load(Params.ITEM_PATH + "i10068.png");
                    _loc_2 = ShopCfgObj.getInstance().getShopItemInfoFromInside(700072);
                    this._txt.htmlText = "<b>" + _loc_2.gold + "</b>";
                    StringTip.create(this, VIPShowCfgObj.getInstance().getProfession(4));
                    break;
                }
                case 2:
                {
                    this._image.load(Params.ITEM_PATH + "i10069.png");
                    _loc_2 = ShopCfgObj.getInstance().getShopItemInfoFromInside(700071);
                    this._txt.htmlText = "<b>" + _loc_2.gold + "</b>";
                    StringTip.create(this, VIPShowCfgObj.getInstance().getProfession(2));
                    break;
                }
                case 1:
                {
                    this._image.load(Params.ITEM_PATH + "i10070.png");
                    _loc_2 = ShopCfgObj.getInstance().getShopItemInfoFromInside(700070);
                    this._txt.htmlText = "<b>" + _loc_2.gold + "</b>";
                    StringTip.create(this, VIPShowCfgObj.getInstance().getProfession(1));
                    break;
                }
                default:
                {
                    break;
                }
            }
            this._info = _loc_2;
            return;
        }// end function

        public function get info() : ShopItemInfo
        {
            return this._info;
        }// end function

        public function get select() : Boolean
        {
            return this._selected;
        }// end function

        public function set select(param1:Boolean) : void
        {
            this._selected = param1;
            if (this._bg)
            {
                if (param1)
                {
                    this._bg.gotoAndStop(3);
                    this._mask.visible = false;
                }
                else
                {
                    this._mask.visible = true;
                    this._bg.gotoAndStop(1);
                }
            }
            return;
        }// end function

        private function initUI() : void
        {
            this._txt = getDisplayChildByName("txt");
            this._image = new Image();
            this._image.move(28, 28);
            addChild(this._image);
            this._bg = getDisplayChildByName("bg") as MovieClip;
            this._mask = getDisplayChildByName("bgmask");
            addChild(this._mask);
            this._bg.gotoAndStop(1);
            return;
        }// end function

        private function __over(event:MouseEvent) : void
        {
            if (!this._selected)
            {
                this.over();
            }
            return;
        }// end function

        private function __out(event:MouseEvent) : void
        {
            if (!this._selected)
            {
                this.out();
            }
            return;
        }// end function

        private function over() : void
        {
            this._bg.gotoAndStop(3);
            return;
        }// end function

        private function out() : void
        {
            if (this._bg)
            {
                this._bg.gotoAndStop(1);
            }
            return;
        }// end function

    }
}

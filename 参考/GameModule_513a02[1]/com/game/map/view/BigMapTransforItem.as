package com.game.map.view
{
    import com.cfg.obj.*;
    import com.f1.interfaces.ui.list.*;
    import com.f1.ui.btn.*;
    import com.game.map.control.*;
    import com.game.role.view.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class BigMapTransforItem extends BaseButton implements IItem
    {
        private var _desText:TextField;
        private var _lvText:TextField;
        private var _lvIcon:RoleLevelIcon;
        private var _costText:TextField;
        private var _bg:MovieClip;
        private var _gold:MovieClip;
        private var _index:int;

        public function BigMapTransforItem()
        {
            super("big_map_transfor_item", false);
            this._desText = getDisplayChildByName("mapName");
            this._lvText = getDisplayChildByName("lv");
            this._lvIcon = new RoleLevelIcon();
            this._lvIcon.preLv = "Lv.";
            this._lvIcon.x = this._lvText.x - 15;
            this._lvIcon.y = this._lvText.y;
            this._lvIcon.textColor = this._lvText.textColor;
            this._lvText.parent.addChild(this._lvIcon);
            this._costText = getDisplayChildByName("cost");
            this._bg = getDisplayChildByName("bg") as MovieClip;
            this._gold = getDisplayChildByName("gold") as MovieClip;
            this._bg.stop();
            var _loc_1:* = false;
            this._costText.mouseEnabled = false;
            this._lvText.mouseEnabled = _loc_1;
            this._desText.mouseEnabled = _loc_1;
            this._lvIcon.mouseEnabled = false;
            addEventListener(MouseEvent.CLICK, this._click);
            addEventListener(MouseEvent.MOUSE_OVER, this._over);
            addEventListener(MouseEvent.MOUSE_OUT, this._out);
            return;
        }// end function

        public function set index(param1:int) : void
        {
            return;
        }// end function

        override public function get key()
        {
            return _obj.label;
        }// end function

        override public function set obj(param1) : void
        {
            if (!param1)
            {
                return;
            }
            super.obj = MapCfgObj.getInstance().getMap(param1);
            this.setDes(obj.mapName, obj.mapLimitMinLv, obj.mapTransforCost);
            return;
        }// end function

        override public function setWidth(param1:Number) : void
        {
            display.width = param1;
            return;
        }// end function

        override public function setText(param1:String, param2:Boolean = false) : void
        {
            super.setText(param1);
            return;
        }// end function

        override public function showState(param1:String = "up") : void
        {
            super.showState(param1);
            if (this._bg)
            {
                switch(param1)
                {
                    case "up":
                    {
                        break;
                    }
                    case "over":
                    {
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            return;
        }// end function

        public function setDes(param1:String, param2:int, param3:int) : void
        {
            this._desText.htmlText = param1;
            this._lvText.htmlText = "";
            this._lvIcon.level = param2;
            if (param3 == 0)
            {
                this._costText.text = "";
                this._gold.visible = false;
            }
            else
            {
                this._costText.htmlText = param3.toString();
                this._gold.visible = true;
            }
            return;
        }// end function

        private function _click(event:MouseEvent) : void
        {
            if (obj)
            {
                MapControl.getInstance().goldMapTrans(obj.mapId);
            }
            return;
        }// end function

        private function _over(event:MouseEvent) : void
        {
            this._bg.gotoAndStop(3);
            return;
        }// end function

        private function _out(event:MouseEvent) : void
        {
            this._bg.gotoAndStop(this._index % 2 == 0 ? (1) : (2));
            return;
        }// end function

        override public function finalize() : void
        {
            removeEventListener(MouseEvent.CLICK, this._click);
            super.finalize();
            return;
        }// end function

    }
}

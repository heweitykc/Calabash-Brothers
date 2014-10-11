package com.game.map.view
{
    import com.f1.interfaces.ui.list.*;
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import com.f1.utils.path.*;
    import com.game.autopk.controller.*;
    import com.game.map.control.*;
    import com.game.utils.*;
    import com.model.*;
    import com.staticdata.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import interfaces.role.*;

    public class BigMapRecItem extends Component implements IItem
    {
        private var _desText:TextField;
        private var _transforBtn:BaseButton;
        private var _clickArea:MovieClip;
        private var _obj:Object;
        private var _index:int;

        public function BigMapRecItem()
        {
            super("big_map_rec_item");
            this._clickArea = getDisplayChildByName("clickArea");
            this._desText = getDisplayChildByName("txt");
            this._desText.mouseEnabled = false;
            this._transforBtn = new BaseButton(getDisplayChildByName("btn"));
            this._transforBtn.addEventListener(MouseEvent.CLICK, this._clickTransfor);
            this._clickArea.addEventListener(MouseEvent.CLICK, this._click);
            addEventListener(MouseEvent.MOUSE_OVER, this._over);
            addEventListener(MouseEvent.MOUSE_OUT, this._out);
            return;
        }// end function

        public function get key()
        {
            return this._obj.label;
        }// end function

        public function set obj(param1) : void
        {
            if (!param1)
            {
                return;
            }
            this._obj = param1;
            var _loc_2:* = this._obj.monName;
            this.setDes(_loc_2);
            return;
        }// end function

        public function get obj()
        {
            return this._obj;
        }// end function

        public function set index(param1:int) : void
        {
            this._index = param1;
            this._clickArea.gotoAndStop(this._index % 2 == 0 ? (2) : (1));
            return;
        }// end function

        override public function setWidth(param1:Number) : void
        {
            display.width = param1;
            return;
        }// end function

        public function setDes(param1:String) : void
        {
            if (this._desText)
            {
                this._desText.htmlText = param1;
            }
            return;
        }// end function

        private function _click(event:MouseEvent) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (this._obj)
            {
                _loc_2 = RoleList.getInstance().player;
                AutoFightController.getInstance().closeAutoFight();
                _loc_3 = MapUtils.tile2Coo([this._obj.monX, this._obj.monY]);
                _loc_2.pathByCoo(_loc_3[0], _loc_3[1], 0, this.obj.monMapId, true);
                AutoFightController.getInstance().setArriveCoordVo(this.obj.monMapId, _loc_3[0], _loc_3[1], 0);
            }
            return;
        }// end function

        private function _clickTransfor(event:MouseEvent) : void
        {
            var _loc_2:* = null;
            if (this._obj)
            {
                event.stopImmediatePropagation();
                _loc_2 = new long(0, 0);
                MapControl.getInstance().changeMapByPos(this.obj.monMapId, this.obj.monX, this.obj.monY, _loc_2, 0);
                AutoFightController.getInstance().setArriveCoordVo(this.obj.monMapId, this.obj.monX, this.obj.monY, 0);
            }
            return;
        }// end function

        private function _over(event:MouseEvent) : void
        {
            this.setDes("<font color=\'" + Params.TEXT_SELECTED_COLOR_STR + "\'>" + this._obj.monName + "</font>");
            this._transforBtn.showState("over");
            this._clickArea.gotoAndStop(3);
            return;
        }// end function

        private function _out(event:MouseEvent) : void
        {
            this.setDes(this._obj.monName);
            this._transforBtn.showState("up");
            this._clickArea.gotoAndStop(this._index % 2 == 0 ? (1) : (2));
            return;
        }// end function

        override public function finalize() : void
        {
            this._transforBtn.removeEventListener(MouseEvent.CLICK, this._clickTransfor);
            this._clickArea.removeEventListener(MouseEvent.CLICK, this._click);
            removeEventListener(MouseEvent.MOUSE_OVER, this._over);
            removeEventListener(MouseEvent.MOUSE_OUT, this._out);
            super.finalize();
            return;
        }// end function

        public function get label() : String
        {
            return null;
        }// end function

        public function get selected() : Boolean
        {
            return false;
        }// end function

        public function setSelected(param1:Boolean, param2:Boolean = true) : void
        {
            return;
        }// end function

    }
}

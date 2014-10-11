package com.game.bossrank.view
{
    import __AS3__.vec.*;
    import com.f1.interfaces.ui.list.*;
    import com.f1.ui.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class BossDamageRankItem extends Component implements IItem
    {
        private var txt1:TextField;
        private var txt2:TextField;
        private var txt3:TextField;
        private var mc_box:MovieClip;
        private var _info:Object;
        private var _index:int = 0;
        public static var bossInfoTipsView:BossInfoTipsView = new BossInfoTipsView();

        public function BossDamageRankItem(param1:String = "bossDamageRankListItem")
        {
            super(param1);
            this.initUI();
            return;
        }// end function

        private function initUI() : void
        {
            this.txt1 = getDisplayChildByName("txt1");
            this.txt1.selectable = false;
            this.txt2 = getDisplayChildByName("txt2");
            this.txt2.selectable = false;
            this.txt3 = getDisplayChildByName("txt3");
            this.txt3.selectable = false;
            this.mc_box = getDisplayChildByName("mc_box");
            this.mc_box.visible = false;
            return;
        }// end function

        public function set index(param1:int) : void
        {
            if (param1 == 1)
            {
                var _loc_2:* = 16770390;
                this.txt3.textColor = 16770390;
                this.txt2.textColor = _loc_2;
                this.txt1.textColor = _loc_2;
                this.mc_box.visible = true;
            }
            else if (param1 == 2)
            {
                var _loc_2:* = 33243;
                this.txt3.textColor = 33243;
                this.txt2.textColor = _loc_2;
                this.txt1.textColor = _loc_2;
            }
            else if (param1 == 3)
            {
                var _loc_2:* = 1411328;
                this.txt3.textColor = 1411328;
                this.txt2.textColor = _loc_2;
                this.txt1.textColor = _loc_2;
            }
            else
            {
                var _loc_2:* = 8417369;
                this.txt3.textColor = 8417369;
                this.txt2.textColor = _loc_2;
                this.txt1.textColor = _loc_2;
            }
            this._index = param1;
            return;
        }// end function

        public function get info()
        {
            return this._info;
        }// end function

        public function set obj(param1) : void
        {
            if (!param1)
            {
                return;
            }
            this._info = param1;
            this.setInfo(param1, true);
            return;
        }// end function

        public function refresh() : void
        {
            this.setInfo(this._info, true);
            return;
        }// end function

        private function setInfo(param1:Object, param2:Boolean = false) : void
        {
            if (this._info != param1 || param2)
            {
                this._info = param1;
                if (this._info)
                {
                    this.txt1.text = this._index.toString();
                    this.txt2.text = param1.captainName;
                    this.txt3.text = param1.damage.toString();
                    addEvtListener(MouseEvent.CLICK, this.__click);
                    addEvtListener("rightClick", this.__click);
                    addEvtListener(MouseEvent.DOUBLE_CLICK, this.__click);
                    this.addEventListener(MouseEvent.MOUSE_OVER, this.__over);
                    this.addEventListener(MouseEvent.MOUSE_OUT, this.__out);
                }
                else
                {
                    removeEvtListener(MouseEvent.CLICK, this.__click);
                    removeEvtListener("rightClick", this.__click);
                    removeEvtListener(MouseEvent.DOUBLE_CLICK, this.__click);
                }
            }
            return;
        }// end function

        private function __click(event:MouseEvent) : void
        {
            return;
        }// end function

        private function __over(event:MouseEvent) : void
        {
            var _loc_2:* = null;
            if (this.parent)
            {
                _loc_2 = this.info.teamInfo;
                bossInfoTipsView.update(_loc_2);
                bossInfoTipsView.x = this.x - 20;
                bossInfoTipsView.y = this.y + 20;
                parent.parent.parent.addChild(bossInfoTipsView);
            }
            return;
        }// end function

        private function __out(event:MouseEvent) : void
        {
            if (bossInfoTipsView.parent)
            {
                bossInfoTipsView.parent.removeChild(bossInfoTipsView);
            }
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

        public function get label() : String
        {
            return null;
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

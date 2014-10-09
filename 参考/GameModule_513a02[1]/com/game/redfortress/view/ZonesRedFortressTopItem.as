package com.game.redfortress.view
{
    import com.f1.interfaces.ui.list.*;
    import com.game.redfortress.bean.*;
    import com.game.team.view.*;
    import flash.display.*;
    import flash.text.*;

    public class ZonesRedFortressTopItem extends ListItemBase implements IItem
    {
        private var _txtRank:TextField;
        private var _txtName:TextField;
        private var _txtIntegral:TextField;
        private var _info:CsysTopInfo;
        public static const RANK_PANEL_ITEM:String = "zones_redfortress_top_item";
        public static const RANK_TRACE_ITEM:String = "zones_redfortress_trace_item";

        public function ZonesRedFortressTopItem(param1:String)
        {
            super(param1);
            return;
        }// end function

        override protected function getComp() : void
        {
            var _loc_1:* = MovieClip(_content.getChildByName("back"));
            _loc_1.gotoAndStop(2);
            this._txtRank = TextField(_content.getChildByName("txt_tank"));
            this._txtName = TextField(_content.getChildByName("txt_name"));
            this._txtIntegral = TextField(_content.getChildByName("txt_integral"));
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

        override protected function freshItem() : void
        {
            if (this._info)
            {
                this.setAllTextColor(this.getColor(this._info.ranking));
                this._txtName.text = this._info.playername;
                this._txtRank.text = this._info.ranking.toString();
                this._txtIntegral.text = this._info.integral.toString();
            }
            else
            {
                this._txtName.text = "";
                this._txtRank.text = "";
                this._txtIntegral.text = "";
            }
            return;
        }// end function

        private function getColor(param1:int) : uint
        {
            var _loc_2:* = 0;
            switch(param1)
            {
                case 1:
                {
                    _loc_2 = 16770390;
                    break;
                }
                case 2:
                {
                    _loc_2 = 53693;
                    break;
                }
                case 3:
                {
                    _loc_2 = 1411328;
                    break;
                }
                case 4:
                case 5:
                {
                    _loc_2 = 8417369;
                    break;
                }
                default:
                {
                    _loc_2 = 8417369;
                    break;
                    break;
                }
            }
            return _loc_2;
        }// end function

        private function setAllTextColor(param1:uint) : void
        {
            this._txtName.textColor = param1;
            this._txtRank.textColor = param1;
            this._txtIntegral.textColor = param1;
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

        public function set obj(param1) : void
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

    }
}

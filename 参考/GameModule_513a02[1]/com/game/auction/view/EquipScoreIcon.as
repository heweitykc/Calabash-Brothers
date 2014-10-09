package com.game.auction.view
{
    import com.f1.*;
    import com.f1.ui.imagesNumbericStepper.*;
    import com.f1.utils.*;
    import com.game.backpack.util.*;
    import com.model.vo.*;
    import flash.display.*;

    public class EquipScoreIcon extends BaseSprite
    {
        private var _iconFight:Bitmap;
        private var _fightNumber:ImgNumber;
        private var _info:EquipmentInfo;
        private var _icon:Bitmap;

        public function EquipScoreIcon()
        {
            this._iconFight = ToolKit.getNewDO("equip_fight_num") as Bitmap;
            this._iconFight.y = 1;
            addChild(this._iconFight);
            return;
        }// end function

        public function get info() : EquipmentInfo
        {
            return this._info;
        }// end function

        public function set info(param1:EquipmentInfo) : void
        {
            this._info = param1;
            this.update();
            return;
        }// end function

        private function update() : void
        {
            var _loc_1:* = EquipUtil.compareEquip(this._info);
            if (_loc_1 != 0)
            {
                ToolKit.disappear(this._icon);
                if (_loc_1 == 1)
                {
                    this._icon = ToolKit.getNewDO("equipvalueup") as Bitmap;
                }
                else if (_loc_1 == 2)
                {
                    this._icon = ToolKit.getNewDO("equipvaluedown") as Bitmap;
                }
            }
            if (this._fightNumber == null)
            {
                this._fightNumber = new ImgNumber();
            }
            if (_loc_1 == 0)
            {
                ToolKit.disappear(this._icon);
                this._fightNumber.x = this._iconFight.x + this._iconFight.width + 5;
            }
            else
            {
                this._icon.x = this._iconFight.x + this._iconFight.width + 2;
                addChild(this._icon);
                this._fightNumber.x = this._icon.x + this._icon.width + 5;
            }
            this._fightNumber.setNumber(this._info.fightNumber.toString(), 7, -1);
            addChild(this._fightNumber);
            return;
        }// end function

    }
}

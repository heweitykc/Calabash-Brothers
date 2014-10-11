package com.game.awardGuide.control
{
    import com.game.awardGuide.view.*;
    import com.game.backpack.events.*;
    import com.game.backpack.model.*;
    import com.game.backpack.util.*;
    import com.greensock.*;
    import com.model.*;
    import com.model.vo.*;
    import com.util.*;

    public class EquipAwardGuideControl extends BaseAwardGuideControl
    {
        private var _panel:EquipAwardPanel;
        private static var _instance:EquipAwardGuideControl;

        public function EquipAwardGuideControl()
        {
            return;
        }// end function

        override public function removeGuide(param1:Object) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = null;
            if (guideList)
            {
                _loc_2 = guideList.indexOf(param1);
                if (_loc_2 != -1)
                {
                    guideList.splice(_loc_2, 1);
                }
                _loc_3 = 0;
                while (_loc_3 < guideList.length)
                {
                    
                    _loc_4 = guideList[_loc_3] as EquipmentInfo;
                    if (_loc_4.itemModelId == param1.itemModelId)
                    {
                        guideList.splice(_loc_3, 1);
                        continue;
                    }
                    _loc_3++;
                }
                TweenLite.delayedCall(0.1, this.checkNextGuide);
            }
            return;
        }// end function

        override protected function showGuide(param1:Object) : void
        {
            if (!this._panel)
            {
                this._panel = new EquipAwardPanel();
            }
            this._panel.info = param1 as EquipmentInfo;
            this._panel.open();
            return;
        }// end function

        override protected function checkNeedGuide(param1:Object) : Boolean
        {
            if (!this.checkCanEquip(param1 as PropInfo, UserObj.getInstance().playerInfo))
            {
                return false;
            }
            if (!this.checkFightNumber(param1))
            {
                return false;
            }
            if (!this.checkPoint(param1 as PropInfo, UserObj.getInstance().playerInfo))
            {
                return false;
            }
            return true;
        }// end function

        override protected function removeItem(event:BackpackEvent) : void
        {
            super.removeItem(event);
            var _loc_2:* = event.data as PropInfo;
            if (this._panel && this._panel.info && _loc_2.itemId.equal(this._panel.info.itemId))
            {
                this._panel.close();
            }
            return;
        }// end function

        override protected function checkGuide(param1:Object) : Boolean
        {
            if ((!this._panel || !this._panel.isOpen) && (guideList.length == 0 || guideList[0].itemId.equal(param1.itemId)) && param1 != null)
            {
                return true;
            }
            return false;
        }// end function

        private function checkNextGuide() : void
        {
            var _loc_1:* = null;
            while (guideList && guideList.length > 0)
            {
                
                _loc_1 = guideList[0] as EquipmentInfo;
                _loc_1 = BackpackObj.getInstance().getItemById(_loc_1.itemId) as EquipmentInfo;
                if (this.checkNeedGuide(_loc_1))
                {
                    this.showGuide(_loc_1);
                    break;
                    continue;
                }
                guideList.splice(0, 1);
                this.checkNextGuide();
            }
            return;
        }// end function

        private function checkFightNumber(param1:Object) : Boolean
        {
            if (EquipUtil.compareEquip(param1 as EquipmentInfo) == 1)
            {
                return true;
            }
            return false;
        }// end function

        private function checkCanEquip(param1:PropInfo, param2:PlayerInfo) : Boolean
        {
            if (!PropUtil.jobAdapt(param1, param2.job))
            {
                return false;
            }
            if (param1.unInteractive)
            {
                return false;
            }
            if (param1.q_sex != 0 && param1.q_sex != param2.sex)
            {
                return false;
            }
            if (param1.q_level != 0 && param1.q_level > param2.level)
            {
                return false;
            }
            if (PropUtil.checkItemExpire(param1))
            {
                return false;
            }
            return true;
        }// end function

        private function checkPoint(param1:PropInfo, param2:PlayerInfo) : Boolean
        {
            var _loc_3:* = 0;
            if (param1.q_str_limit > param2.strength)
            {
                _loc_3 = _loc_3 + (param1.q_str_limit - param2.strength);
            }
            if (param1.q_agile_limit > param2.agile)
            {
                _loc_3 = _loc_3 + (param1.q_agile_limit - param2.agile);
            }
            if (param1.q_int_limit > param2.intelligence)
            {
                _loc_3 = _loc_3 + (param1.q_int_limit - param2.intelligence);
            }
            if (param1.q_vit_limit > param2.vitality)
            {
                _loc_3 = _loc_3 + (param1.q_vit_limit - param2.vitality);
            }
            if (_loc_3 <= param2.unallocatedTalent)
            {
                return true;
            }
            return false;
        }// end function

        public static function getInstance() : EquipAwardGuideControl
        {
            var _loc_1:* = new EquipAwardGuideControl;
            _instance = new EquipAwardGuideControl;
            return _instance || _loc_1;
        }// end function

    }
}

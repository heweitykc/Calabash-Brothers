package com.game.bossrank.view
{
    import __AS3__.vec.*;
    import com.f1.ui.*;
    import com.f1.ui.list.*;
    import flash.display.*;

    public class BossInfoTipsView extends Component
    {
        private var mc_List:MovieClip;
        private var _list:List;
        private var _bossDamageTeamItem:BossDamageTeamItem;
        private var teamInfo:Vector.<TeamMemberDamage>;

        public function BossInfoTipsView(param1 = null, param2:String = null)
        {
            super(param1, param2);
            loadDisplay("res/bossdamagerank.swf");
            return;
        }// end function

        override protected function displayReady() : void
        {
            initComponentUI("bossInfoTips");
            this.initUI();
            this.addEvents();
            super.displayReady();
            return;
        }// end function

        private function initUI() : void
        {
            this.mc_List = getDisplayChildByName("mc_List");
            this._list = new List(245, 93);
            this._list.scroll.visible = false;
            this.mc_List.addChild(this._list);
            this.mouseChildren = false;
            this.mouseEnabled = false;
            this.update(this.teamInfo);
            return;
        }// end function

        private function addEvents() : void
        {
            return;
        }// end function

        public function update(param1:Vector.<TeamMemberDamage> = null) : void
        {
            var _loc_2:* = 0;
            this.teamInfo = param1;
            if (UILoaded)
            {
                this._list.reset();
                _loc_2 = 0;
                while (param1 && _loc_2 < param1.length)
                {
                    
                    this._bossDamageTeamItem = new BossDamageTeamItem();
                    this._bossDamageTeamItem.index = _loc_2 + 1;
                    this._bossDamageTeamItem.obj = param1[_loc_2];
                    this._list.add(this._bossDamageTeamItem);
                    _loc_2++;
                }
            }
            return;
        }// end function

    }
}

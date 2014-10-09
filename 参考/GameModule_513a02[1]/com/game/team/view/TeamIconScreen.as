package com.game.team.view
{
    import com.f1.ui.btn.*;
    import com.game.team.control.*;
    import flash.display.*;
    import flash.events.*;

    public class TeamIconScreen extends BaseButton
    {
        private var teamMemberCount:MovieClip;

        public function TeamIconScreen()
        {
            super("icon_team_show_arean");
            this.initUI();
            this.addEvent();
            return;
        }// end function

        private function initUI() : void
        {
            this.teamMemberCount = MovieClip(getDisplayChildByName("team_member_count"));
            return;
        }// end function

        private function addEvent() : void
        {
            this.addEventListener(MouseEvent.CLICK, this.mouseClickHandler);
            return;
        }// end function

        protected function mouseClickHandler(event:MouseEvent) : void
        {
            TeamControl.getInstance().openOrCloseTeam();
            return;
        }// end function

        public function setCount(param1:int) : void
        {
            this.teamMemberCount.gotoAndStop(param1);
            return;
        }// end function

    }
}

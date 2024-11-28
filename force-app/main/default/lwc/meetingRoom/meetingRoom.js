import { LightningElement, api } from 'lwc';

export default class MeetingRoom extends LightningElement {
    @api meetingRoomInfo = {roomName:'A-01', roomCapacity:'8'}
   @api showRoomInfo = false;

   tileClickHandler(){
       const tileClicked = new CustomEvent('tileClick', {detail: this.meetingRoomInfo, bubbles : true})
        this.dispatchEvent(tileClicked);
    }
}
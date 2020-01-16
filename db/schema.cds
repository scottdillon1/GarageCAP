namespace scp.cloud;

using {
  cuid,
  managed,
  sap.common
} from '@sap/cds/common';

entity SafetyIncidents : cuid, managed {
  title                  : String(50)                    @title : 'Title';
  category               : Association to Category       @title : 'Category';
  priority               : Association to Priority       @title : 'Priority';
  incidentStatus         : Association to IncidentStatus @title : 'IncidentStatus';
  description            : String(1000)                  @title : 'Description';
  incidentResolutionDate : Date                          @title : 'ResolutionDate';
  assignedIndividual     : Association to Individual;
  incidentPhotos         : Association to many IncidentPhotos
                             on incidentPhotos.safetyIncident = $self;
}

entity Individual : cuid, managed {
      firstName       : String @title : 'First Name';
      lastName        : String @title : 'Last Name';
      emailAddress    : String @title : 'Email Address';
      safetyIncidents : Association to many SafetyIncidents
                          on safetyIncidents.assignedIndividual = $self;
}

entity IncidentPhotos : cuid, managed {
  @Core.isMediaType : true imageType  : String;
  @Core.MediaType   : ImageType image : LargeBinary;
  safetyIncident                      : Association to SafetyIncidents;
}

entity IncidentsCodeList : common.CodeList {
  key code : String(20);
}

entity Category : IncidentsCodeList {}
entity Priority : IncidentsCodeList {}
entity IncidentStatus : IncidentsCodeList {}
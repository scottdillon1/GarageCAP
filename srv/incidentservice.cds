using scp.cloud from '../db/schema';

service IncidentService {
    //@odata.draft.enabled
    entity SafetyIncidents as projection on cloud.SafetyIncidents;

    entity IncidentPhotos as projection on cloud.IncidentPhotos;

    entity IncidentsByCategory as select from cloud.SafetyIncidents {count(ID) as categories:Integer,key category} Group By category;

    @readyonly entity Individual as projection on cloud.Individual;
    @readonly entity Category as projection on cloud.Category;
    @readonly entity Priority as projection on cloud.Priority;
}
module.exports = function (service) {
  // sets default priority dependending on category
  service.before('CREATE', 'SafetyIncidents', (req) => {
    console.log('using handler for before')
    const incident = req.data
    incident.priority_code = incident.priority_code || incident.category_code === 'safety' ? 'high' : 'normal'
    req.on('succeeded', () => {
      console.log('Succeeded2')
      service.emit("SafetyIncident/Created", { ID: incident.ID, category_code: incident.category_code })
    }
    )
  }
  )
  service.on("SafetyIncident/Created", msg=>{console.log('Message received',msg.data)})
}
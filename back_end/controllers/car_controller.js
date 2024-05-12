// importData.js
const Manufacturer = require('../models/carManufacturer');
const CarModel = require('../models/carModel');
const jsonData = require('../../cars.json'); // Assuming your JSON data is in a file

async function importData ()   {
  try {
    for (const manufacturerData of jsonData) {
      const manufacturer = await Manufacturer.create({
        id: manufacturerData.id,
        name: manufacturerData.name,
        cyrillicName: manufacturerData['cyrillic-name'],
        popular: manufacturerData.popular,
        country: manufacturerData.country,
      });

      for (const modelData of manufacturerData.models) {
        await CarModel.create({
          idModel: modelData.id,
          name: modelData.name,
          cyrillicName: modelData['cyrillic-name'],
          class: modelData.class,
          yearFrom: modelData['year-from'],
          yearTo: modelData['year-to'],
          ManufacturerId: manufacturer.id, // Associate the model with the manufacturer using the foreign key
        });
      }
    }
    console.log('Data imported successfully!');
  } catch (error) {
    console.error('Error importing data:', error);
  }
};

async function getAllManufacturer(req, res) {
  try {
    const allManufacturerIds = await Manufacturer.findAll({
      attributes: ['id'],
    });

    const manufacturerIds = allManufacturerIds.map(manufacturer => manufacturer.id);

    res.status(200).json(manufacturerIds);
  } catch (error) {
    console.error('Error fetching all manufacturer IDs:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
}

async function getAllModels(req, res) {
  try {
    params = req.params;
    const allModels = await CarModel.findAll({
    where:{
      ManufacturerId:req.params.manufacturerId
    }});

    const manufacturerIds = allModels.map(model => model.idModel);

    res.status(200).json(manufacturerIds);
  } catch (error) {
    console.error('Error fetching all manufacturer IDs:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
}


module.exports={importData,getAllManufacturer,getAllModels}
// A
db.facilities.find(
    {
        "roomtype": { $regex: "touros" },
        "activities": "teatro"
    },
    {
        "_id": 1,
        "name": 1,
        "roomtype": 1,
        "activities": 1
    }
);

// B
db.facilities.aggregate([
    {
        $match:
        {
            "roomtype": { $regex: "touros" }
        }
    },
    {
        $group:
        {
            _id: "$municipality.region.designation",
            n_facilities: { $sum: 1 }
        }
    }
]);

// C
db.municipalities.count() - db.facilities.aggregate(
    {
        $match: {
            "activities": { $in: ["cinema"] }
        }
    },
    {
        $group: {
            _id: "$municipality.designation",
            n_facilities: { $sum: 1 }
        }
    }
).toArray().length;

// 4
db.facilities.aggregate([
    {
        $unwind: "$activities"
    },
    {
        $group:
        {
            "_id": { municipality: "$municipality.designation", activity: "$activities" },
            "total": { $sum: 1 }
        }
    },
    {
        $sort:
            { "total": -1 }
    },
    {
        $group:
        {
            "_id": "$_id.activity",
            "municipality": { "$first": "$_id.municipality" },
            "n_facilities": { $max: "$total" }
        }
    },
    {
        $sort: { "_id": 1 }
    },

]);

// E
db.municipalities.aggregate([
    {
        $lookup:
        {
            from: 'facilities',
            localField: '_id',
            foreignField: 'municipality._id',
            as: 'facilities'
        }
    },
    {
        $group:
        {
            _id: { _id: "$district._id", designation: "$district.designation" },
            municipalities: { $push: { nome: "$designation", hasFacilities: {
                $gt: [{ $size: "$facilities" }, 0]
            } } }
        },
    },
    {
        $match: { "municipalities": { "$not": { "$elemMatch": { "hasFacilities": false } } } }
    },
    {
        $group: { _id: "$_id._id", designation: { $first: "$_id.designation" } }
    }
]);